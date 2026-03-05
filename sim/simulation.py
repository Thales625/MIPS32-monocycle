import cocotb
from cocotb.triggers import Timer
from time import time

from visualizer import Window

@cocotb.test()
async def testbench(dut):
    # init DPG Window
    Window.init(dut)

    # apply reset
    Window.log("Applying reset...")
    dut.reset.value = 0
    await Timer(10, unit="ns")
    dut.reset.value = 1
    await Timer(10, unit="ns")
    dut.reset.value = 0
    Window.log("CPU reseted.")
    
    Window.log("Simulation started.")
    last_render_time = time()

    cycle = 0
    CYCLES_PER_FRAME = 10
    while Window.running():
        current_time = time()

        if (current_time - last_render_time) > (1.0 / 30.0):
            Window.render()
            last_render_time = current_time

        # play mode
        if Window.is_running:
            for _ in range(CYCLES_PER_FRAME):
                dut.clock.value = 1
                await Timer(1, unit="ns")
                dut.clock.value = 0
                await Timer(1, unit="ns")

                cycle += 1

            Window.update(cycle)

        # step request
        elif Window.step_requested:
            dut.clock.value = 1
            await Timer(1, unit="ns")
            dut.clock.value = 0
            await Timer(1, unit="ns")

            cycle += 1

            Window.update(cycle)
            Window.step_requested = False

        # reset request
        elif Window.reset_requested:
            Window.log("Applying reset...")
            dut.reset.value = 1
            await Timer(10, unit="ns")
            dut.reset.value = 0
            Window.log("CPU reseted.")

            Window.reset_requested = False
            cycle = 0
            Window.update(cycle)

        # pause mode
        else:
            await Timer(1, unit="ns")
        
    Window.destroy()

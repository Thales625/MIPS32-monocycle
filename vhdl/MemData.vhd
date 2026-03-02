library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity Memoria_Dados is
    generic (
        ADDR_WIDTH : integer := 8;
        INIT_FILE  : string := "../compiler/data.bin"
    );
    port (
        clk      : in  std_logic;
        EscMem   : in  std_logic;
        LerMem   : in  std_logic;
        endereco : in  std_logic_vector(31 downto 0);
        dado_in  : in  std_logic_vector(31 downto 0);
        dado_out : out std_logic_vector(31 downto 0)
    );
end entity Memoria_Dados;

architecture rtl of Memoria_Dados is
    type ram_type is array (0 to (2**ADDR_WIDTH)-1) of std_logic_vector(31 downto 0);

    impure function init_ram_from_file(file_name : in string) return ram_type is
        file text_file       : text open read_mode is file_name;
        variable text_line   : line;
        variable ram_content : ram_type := (others => (others => '0'));
        variable bin_value   : bit_vector(31 downto 0);
    begin
        for i in 0 to (2**ADDR_WIDTH)-1 loop
            if not endfile(text_file) then
                readline(text_file, text_line);
                read(text_line, bin_value);
                ram_content(i) := to_stdlogicvector(bin_value);
            end if;
        end loop;
        return ram_content;
    end function;

    signal ram : ram_type := init_ram_from_file(INIT_FILE);
    signal indice_palavra : unsigned(ADDR_WIDTH-1 downto 0);
begin
    --
    indice_palavra <= unsigned(endereco(ADDR_WIDTH + 1 downto 2));

    --escrita sinc
    process(clk)
    begin
        if rising_edge(clk) then
            if EscMem = '1' then
                ram(to_integer(indice_palavra)) <= dado_in;
            end if;
        end if;
    end process;

    --leitura assinc
    dado_out <= ram(to_integer(indice_palavra)) when LerMem = '1' else (others => '0');

end architecture rtl;

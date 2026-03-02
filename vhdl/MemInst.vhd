library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity Memoria_Instrucoes is
    generic (
        ADDR_WIDTH : integer := 8;
        INIT_FILE  : string := "../compiler/code.bin"
    );
    port (
        endereco  : in  std_logic_vector(31 downto 0);
        instrucao : out std_logic_vector(31 downto 0)
    );
end Memoria_Instrucoes;

architecture rtl of Memoria_Instrucoes is
    type rom_type is array (0 to (2**ADDR_WIDTH)-1) of std_logic_vector(31 downto 0);
    
    impure function init_rom_from_file(file_name : string) return rom_type is
        file text_file : text open read_mode is file_name;
        variable text_line : line;
        variable rom_content : rom_type := (others => (others => '0')); -- default zero
        variable bin_value : bit_vector(31 downto 0);
    begin
        for i in 0 to (2**ADDR_WIDTH)-1 loop
            if not endfile(text_file) then
                readline(text_file, text_line);
                read(text_line, bin_value);
                rom_content(i) := to_stdlogicvector(bin_value);
            end if;
        end loop;
        return rom_content;
    end function;

    signal rom : rom_type := init_rom_from_file(INIT_FILE);
    
    signal indice_palavra : unsigned(ADDR_WIDTH-1 downto 0);
begin
    -- avanca de 4 em 4 bytes
    indice_palavra <= unsigned(endereco(ADDR_WIDTH + 1 downto 2));

    -- saida
    instrucao <= rom(to_integer(indice_palavra));
end rtl;

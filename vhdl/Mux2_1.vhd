library IEEE;
use IEEE.std_logic_1164.all;

entity Mux2_1 is
    generic (N : integer := 16);
    port(
        A, B : in std_logic_vector(N-1 downto 0);
        sel  : in std_logic;
        Y    : out std_logic_vector(N-1 downto 0)
    );
end Mux2_1;

architecture arch of Mux2_1 is

begin
    with sel select
        Y <= A when '0',
             B when others; 
end arch;

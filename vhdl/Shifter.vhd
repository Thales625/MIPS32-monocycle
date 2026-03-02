library IEEE;
use IEEE.std_logic_1164.all;

entity Shifter is
    generic (N : integer := 32);
    port(
        A       : in std_logic_vector(N-1 downto 0);
        dir_esq : in std_logic; -- 0 = esquerda, 1 = direita
        S       : out std_logic_vector(N-1 downto 0)
    );
end Shifter;

architecture arch of Shifter is
    signal dir, esq : std_logic_vector(N-1 downto 0);

begin
    dir <= '0' & A(N-1 downto 1);
    esq <= A(N-2 downto 0) & '0';
    
    S <= esq when dir_esq = '0' else dir;
end arch;

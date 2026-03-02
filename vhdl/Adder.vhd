library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Adder is
generic (N : integer := 32);
port(
    A, B : in std_logic_vector(N-1 downto 0);
    S    : out std_logic_vector(N-1 downto 0);
    Cout : out std_logic);
end Adder;

architecture arch of Adder is
    signal temp : unsigned(N downto 0);
begin
    temp <= ('0' & unsigned(A)) + ('0' & unsigned(B));

    S    <= std_logic_vector(temp(N-1 downto 0));
    Cout <= temp(N);

end arch;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity multiplier is
  port (
    a : in std_logic_vector(15 downto 0); -- 16-bit input
    b : in std_logic_vector(15 downto 0); -- 16-bit input
    dout : out std_logic_vector(31 downto 0) -- 32-bit output
  );
end multiplier;

architecture behav of multiplier is
begin
  process(a, b)
  begin
    dout <= std_logic_vector(signed(a) * signed(b)); -- Convert and multiply
  end process;
end behav;

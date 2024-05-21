library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t_multiplier is
end t_multiplier;

architecture behav of t_multiplier is

  component multiplier is
    port (
      a : in integer;
      b : in integer;
      dout : out integer
    );
  end component;

  signal a, b, dout : integer;

begin

  a1 : multiplier
    port map (
      a => a,
      b => b,
      dout => dout
    );

  stim_proc: process
  begin
    a <= 3;
    b <= 4;
    wait for 1 ns;
    assert dout = 12 report "Test failed for a=3, b=4" severity error;

    a <= 5;
    b <= 6;
    wait for 1 ns;
    assert dout = 30 report "Test failed for a=5, b=6" severity error;

    a <= -2;
    b <= 7;
    wait for 1 ns;
    assert dout = -14 report "Test failed for a=-2, b=7" severity error;

  wait;
  end process;

end behav;

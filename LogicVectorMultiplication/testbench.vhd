library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t_multiplier is
end t_multiplier;

architecture behav of t_multiplier is

  component multiplier is
    port (
      a : in std_logic_vector(15 downto 0);
      b : in std_logic_vector(15 downto 0);
      dout : out std_logic_vector(31 downto 0)
    );
  end component;

  signal a, b : std_logic_vector(15 downto 0);
  signal dout : std_logic_vector(31 downto 0);

begin

  uut : multiplier
    port map (
      a => a,
      b => b,
      dout => dout
    );

  stim_proc: process
  begin
    -- Test case 1
    a <= std_logic_vector(to_signed(3, 16));
    b <= std_logic_vector(to_signed(4, 16));
    wait for 1 ns;
    assert dout = std_logic_vector(to_signed(12, 32)) report "Test failed for a=3, b=4" severity error;

    -- Test case 2
    a <= std_logic_vector(to_signed(5, 16));
    b <= std_logic_vector(to_signed(6, 16));
    wait for 1 ns;
    assert dout = std_logic_vector(to_signed(30, 32)) report "Test failed for a=5, b=6" severity error;

    -- Test case 3
    a <= std_logic_vector(to_signed(-2, 16));
    b <= std_logic_vector(to_signed(7, 16));
    wait for 1 ns;
    assert dout = std_logic_vector(to_signed(-14, 32)) report "Test failed for a=-2, b=7" severity error;

    wait;
  end process;

end behav;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity t_array_multiplier is
end t_array_multiplier;

architecture behav of t_array_multiplier is

  component array_multiplier is
    generic (
      N : integer := 4 -- Number of 16-bit multiplications
    );
    port (
      a_array : in std_logic_vector(16*N-1 downto 0);
      b_array : in std_logic_vector(16*N-1 downto 0);
      dout_array : out std_logic_vector(32*N-1 downto 0)
    );
  end component;

  signal a_array, b_array: std_logic_vector(16*4-1 downto 0);
  signal  dout_array: std_logic_vector(32*4-1 downto 0);

begin

  uut : array_multiplier
    generic map (
      N => 4
    )
    port map (
      a_array => a_array,
      b_array => b_array,
      dout_array => dout_array
    );

  stim_proc: process
  begin
    -- Initial wait to allow for initialization
    wait for 10 ns;

    -- Test case 1
    a_array <= std_logic_vector(to_signed(3, 16) & to_signed(5, 16) & to_signed(-2, 16) & to_signed(7, 16));
    b_array <= std_logic_vector(to_signed(4, 16) & to_signed(6, 16) & to_signed(7, 16) & to_signed(2, 16));
    wait for 10 ns; -- Allow time for the signals to propagate

    -- Print the input arrays
    report "a_array: " & integer'image(to_integer(signed(a_array(63 downto 48)))) &
           ", " & integer'image(to_integer(signed(a_array(47 downto 32)))) &
           ", " & integer'image(to_integer(signed(a_array(31 downto 16)))) &
           ", " & integer'image(to_integer(signed(a_array(15 downto 0))));
    
    report "b_array: " & integer'image(to_integer(signed(b_array(63 downto 48)))) &
           ", " & integer'image(to_integer(signed(b_array(47 downto 32)))) &
           ", " & integer'image(to_integer(signed(b_array(31 downto 16)))) &
           ", " & integer'image(to_integer(signed(b_array(15 downto 0))));
    
    -- Print the output array
    report "dout_array: " & integer'image(to_integer(signed(dout_array(127 downto 96)))) &
           ", " & integer'image(to_integer(signed(dout_array(95 downto 64)))) &
           ", " & integer'image(to_integer(signed(dout_array(63 downto 32)))) &
           ", " & integer'image(to_integer(signed(dout_array(31 downto 0))));

    assert dout_array = std_logic_vector(to_signed(12, 32) & to_signed(30, 32) & to_signed(-14, 32) & to_signed(14, 32))
      report "Test failed for a_array and b_array" severity error;

    -- Additional test cases can be added here

    wait;
  end process;

end behav;

library ieee;
use ieee.std_logic_1164.all;

package types is
  alias logic is std_ulogic;
  alias voltage is real;
end package;

context physical_simulation is
  library ieee;
  use ieee.std_logic_1164.all;
  use ieee.math_real.all;
end context;

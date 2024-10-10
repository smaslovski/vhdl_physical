context work.physical_simulation;
use work.types.all;

entity schmitt_inv is
  generic (
    THRESHOLD_L, THRESHOLD_H : voltage
  );
  port (
    trig_in  : in  voltage;
    trig_out : out logic
  );
end entity;

architecture behav of schmitt_inv is
begin

  trigger: process (trig_in) is
    variable q : logic;
  begin

    if trig_in > THRESHOLD_H then
      q := '1';
    elsif trig_in < THRESHOLD_L then
      q := '0';
    end if;

    trig_out <= not q;

  end process;

end architecture;

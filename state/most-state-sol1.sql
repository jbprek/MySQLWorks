# Solution 1
select mpin,tin,state,sn,dt
from in_tbl;

create or replace view state_count_by_mpst_view as (
   select mpin,tin,state, count(state) as state_count
   from in_tbl
   group by mpin,tin,state
);

select * from
    state_count_by_mpst_view ;

create or replace view state_max_count_by_mpcnt_view as
(
select mpin, tin, state_count, max(state_count) as maxi
from state_count_by_mpst_view
group by mpin, tin, state_count
having  count(*) = 1
);

select * from state_max_count_by_mpcnt_view;

create or replace view most_state_view as
(
select mpin,tin, state_count, maxi from state_max_count_by_mpcnt_view
where maxi = (select max(maxi) from state_max_count_by_mpcnt_view )
);

select * from most_state_view;

create or replace view most_state as (
select mpin, tin, state
from state_count_by_mpst_view l right  outer join most_state_view r
using (mpin, tin, state_count));

select * from most_state;

# Verify
select
    l.mpin,
    l.tin,
    l.dt,
    l.sn,
    r.state

from in_tbl l left join  most_state r
using(mpin,tin)
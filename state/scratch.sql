select mpin,tin,state,sn,dt
from in_tbl;

create or replace view state_count as (
   select mpin,tin,state, count(state) as state_count
   from in_tbl
   group by mpin,tin,state
);

select * from
state_count ;

create or replace view state_count_max as
(
select mpin, tin, state_count, max(state_count) as maxi
from state_count
group by mpin, tin, state_count
having  count(*) = 1
);

select * from state_count_max;

create or replace view count_with_max as
(
select mpin,tin, state_count, maxi from state_count_max
where maxi = (select max(maxi) from state_count_max )
);

select * from count_with_max;


select mpin, tin, state
from state_count l right  outer join count_with_max r
using (mpin, tin, state_count)
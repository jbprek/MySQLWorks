# Solution 1
select mpin, tin, state, sn, dt
from in_tbl;

create or replace view min_sn_per_mpstate_view as
(
select mpin, tin, state, min(sn) as min_sn
from in_tbl
group by mpin, tin, state
    );

select *
from min_sn_per_mpstate_view;



create or replace view min_sn_view as
(
select t1.mpin, t1.tin, t1.min_sn
from min_sn_per_mpstate_view t1
         inner join (select mpin, tin,  min(min_sn) as min_sn
                     from min_sn_per_mpstate_view t2
                     group by mpin, tin) t2
                    using (mpin, tin, min_sn)
    );


select *
from min_sn_view;

create or replace view min_sn_state as
(
select mpin, tin, state
from min_sn_per_mpstate_view l
         right outer join min_sn_view r
                          using (mpin, tin, min_sn));

select *
from min_sn_state;

# Verify
select l.mpin,
       l.tin,
       l.dt,
       l.sn,
       r.state

from in_tbl l
         left join min_sn_state r
                   using (mpin, tin)
# Solution 1
select mpin, tin, state, sn, dt
from in_tbl;

create or replace view min_date_per_mpstate_view as
(
select mpin, tin, state, min(str_to_date(dt, '%Y-%m-%d')) as min_dt
from in_tbl
group by mpin, tin, state
    );

select *
from min_date_per_mpstate_view;

-- Single minimum dt per mpin,pin
create or replace view min_date_no_ties_view as
(
select mpin,
       tin,
       min_dt
#      , min(min_dt) as min_min_dt
from min_date_per_mpstate_view
group by mpin, tin, min_dt
having count(*) = 1
    );

select *
from min_date_no_ties_view;

create or replace view min_date_view as
(
select t1.mpin, t1.tin, t1.min_dt
from min_date_no_ties_view t1
         inner join (select mpin, tin, min(min_dt) as min_dt
                     from min_date_no_ties_view t2
                     group by mpin, tin) t2
                    using (mpin, tin, min_dt)
    );


select *
from min_date_view;

create or replace view min_date_state as
(
select mpin, tin, state
from min_date_per_mpstate_view l
         right outer join min_date_view r
                          using (mpin, tin, min_dt));

select *
from min_date_state;

# Verify
select l.mpin,
       l.tin,
       l.dt,
       l.sn,
       r.state

from in_tbl l
         left join min_date_state r
                   using (mpin, tin)
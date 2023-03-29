select mpin,tin,state,dt,sn
from in_tbl

-- Occurrences of state per mpin,tin
select mpin,tin,state, count(state) as count_state
from in_tbl
group by mpin,tin,state

-- Occurrences of state per mpin,tin
select mpin,tin,state, count(state) as count_state
from in_tbl
group by mpin,tin,state


select mpin,tin,state, count(state) as count_state
from in_tbl
group by mpin,tin,state

select l.mpin,
       l.tin,
       l.dt,
       l.sn,
       coalesce(ms.state,dt.state, min_sn.state)

from in_tbl l

         left join most_state ms
                   on l.mpin = ms.mpin and
                      l.tin = ms.tin
         left join min_date_state dt
                   on l.mpin = dt.mpin and
                      l.tin = dt.tin
         left join min_sn_state min_sn
         on l.mpin = min_sn.mpin and
            l.tin = min_sn.tin
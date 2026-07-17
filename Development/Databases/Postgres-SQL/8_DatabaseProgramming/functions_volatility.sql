SET search_path TO music_store;

-- Functions allow the specification of volatility.
--      IMMUTABLE: The function guarantees to return the same result given the same arguments, regardless of database changes or time
--      STABLE: Function may read tables, but not modify them
--      VOLATILE: Function reading data may return different results. Functions inserting, updating, deleting data must be declared volatile.
-- VOLATLIE is default. Stable and Immutable offer better performance.


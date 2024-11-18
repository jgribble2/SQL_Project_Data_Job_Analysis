-- Modify the remote column so that it defaults to FALSE in the data_science_job table

ALTER TABLE data_science_jobs
ALTER COLUMN remote SET DEFAULT FALSE;
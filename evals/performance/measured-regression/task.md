Apply the /performance skill. Our nightly report job went from 8 minutes to 51
minutes after the last release. Here's the cProfile output, sorted by cumulative
time, top entries only:

```
   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.001    0.001 3061.442 3061.442 report.py:12(run_nightly)
   240310    1.204    0.000 2884.219    0.012 report.py:88(enrich_row)
   240310    0.998    0.000 2801.550    0.012 client.py:41(get_exchange_rate)
   240310    2.113    0.000 2794.882    0.012 requests/api.py:59(get)
        1    0.882    0.882  118.330  118.330 report.py:150(write_csv)
   240310   14.900    0.000   94.200    0.000 report.py:160(format_row)
        1   28.440   28.440   28.440   28.440 report.py:200(sort_rows)
```

The release added currency normalization. Someone suggested rewriting
`format_row` in Cython, and someone else wants to parallelize `sort_rows`.

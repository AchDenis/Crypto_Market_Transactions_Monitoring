# Crypto Market Transactions Monitoring
A method to solve the Crypto Market Transactions Monitoring given by Hacker Ranke for SQL advance certification.
Below is the requirements provided during the exam:

As part of a cryptocurrency trade monitoring platform, create a query to return a list of
suspicious transactions.

## Suspicious transactions are defined as:
- a series of two or more transactions occur at intervals of an hour or less
- they are from the same sender
- the sum of transactions in a sequence is 150 or greater

A sequence of suspicious transactions may occur over time periods greater than one hour. As
an example, there are 5 transactions from one sender for 30 each. They occur at intervals of
less than an hour between from 8 AM to 11 AM. These are suspicious and will all be reported
as one sequence that starts at 8 AM, ends at 11 AM, with 5 transactions that sum to 150.

### The result should have the following columns: sender, sequence_start, sequence_end,transactions_count, transactions_sum  
- sender is the sender's address.
- sequence_start is the timestamp of the first transaction in the sequence.
- sequence_end is the timestamp of the last transaction in the sequence.
- transactions_count is the number of transactions in the sequence.
- transactions_sum is the sum of transaction amounts in the sequence, to 6 places after the
decimal.


Order the data ascending, first by sender, then by sequence_start, and finally
by sequence_end.

**You have the following tables available:**

![18](https://github.com/user-attachments/assets/104fdde3-1514-4701-a6e8-2b7599d3407a)


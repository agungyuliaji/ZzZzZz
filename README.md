# Setup

- ruby: 3.3.6
- rails: 8.0.0
- database: SQLite... :)

```bash
# setup everything including data seeds
bin/setup

# run..
rails s
```

# Base Concept

```mermaid
stateDiagram-v2
  [*] --> User.rb
  state User.rb {
    [*] --> sleep
    sleep --> wake_up
    wake_up --> reset
    reset --> sleep
    wake_up --> completed_cycle
    completed_cycle --> [*]
  }

  User.rb --> SleepRecord.rb
  state SleepRecord.rb {
    [*] --> recordData
    recordData: Record clock_in_time, clock_out_time, and duration
    recordData --> [*]
  }

```

# Postman Collection

Import this [Collection (v2.1)](doc/sleep_records.postman_collection.json) file.

![alt text](doc/postman_screenshot.png)

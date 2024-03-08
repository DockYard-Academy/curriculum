# Elixir curriculum builder

Directory structure

```
|── livebooks
│   ├── day2.livemd    -> outline file
│   ├── start.livemd   -> outline file
│   ├── exercise       -> templates db
│   ├── presentation   -> templates db
│   └── reading        -> templates db
└── release
    └── day2           -> released livebook bundle (to be shared with students)
```

## Mix Tasks

Compile release bundle (path to outline livebook as arg)

```sh
$ mix all_tasks livebooks/day2.livemd
```

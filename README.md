# DockYard Academy

The DockYard Academy curriculum is an open source curriculum to help students learn Elixir.
The `beta_curriculum` is a work in progress effort available for feedback and contribution.
When launched, this curriculum will be used as the primary teaching material in [DockYard Academy](https://dockyard.com/blog/2022/07/26/what-to-expect-from-the-dockyard-academy-q-a-with-instructor-brooklin-myers).

Contact Brooklin (brooklin.myers@dockyard.com) or DM at [@BrooklinJMyers](https://twitter.com/BrooklinJMyers) on Twitter if you would like more information.

## Want To Get Involved?

Contributors and beta testers are welcome to go through the course, raise issues, and make PRs. See the [Contributor Guide](https://github.com/DockYard-Academy/beta_curriculum/blob/main/CONTRIBUTING.md).

See our list of [Open Issues](https://github.com/DockYard-Academy/beta_curriculum/issues). You can raise an issue to get support.

## QuickStart

The following QuickStart Guide will let you quickly try the course. For a long-term setup, follow our [Student Setup Guide](https://github.com/DockYard-Academy/beta_curriculum/wiki/Student-Setup-Guide).

The recommended installation methods for this course are from the Elixir language [website](https://elixir-lang.org/install.html#gnulinux). If you cannot see [mermaid.js](https://github.com/mermaid-js/mermaid) graphs, please ensure your Livebook version is correct. 

In the future when working with multiple Elixir projects, there is a tool called [`asdf`](https://github.com/asdf-vm/asdf) that can be used to install different versions of Erlang/Elixir as defined by the [.tool-versions](https://github.com/DockYard-Academy/beta_curriculum/blob/main/.tool-versions) file in a project.

### MacOS

1. Clone the project
   - `git clone https://github.com/DockYard-Academy/beta_curriculum.git`

2. Install Elixir
   - `brew install elixir`

3. Install [Livebook](https://github.com/livebook-dev/livebook)
   - `mix escript.install hex livebook`
   - You may prefer to install [Livebook Desktop](https://livebook.dev/#install) instead of running Livebook with an `escript`.

4. Start the Livebook server and open the navigation page where you can find the course reading material and associated exercises
   - `livebook server start.livemd`

### Windows

1. Clone the project
   - `git clone https://github.com/DockYard-Academy/beta_curriculum.git`

2. Install Elixir
   - Download the installer [here](https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.2/elixir-websetup.exe) and run it. You will get a Windows Defender notice (don't worry) and select "More info" and "Run anyways" then follow the instructions with the default settings.
   - NOTE: You need to type `iex.bat` instead of `iex` when starting the interactive REPL.
   - Run `iex.bat --sname test` to trigger a firewall prompt that needs to be accepted to run Livebook.
   - Run  `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine` in an administrator terminal in order to use `mix`.

3. Install [Livebook](https://github.com/livebook-dev/livebook)
   - `mix escript install hex livebook`
   - After installing you will see a prompt that says you need to add `c:/Users/YOUR_USERNAME/.mix/escripts` to the system PATH. Search for `Set the system environments variables` and it will open the Control Panel section. Under the "Advanced" tab select "Environment Variables", then click on the entry for PATH and the "Edit" button. Select "New" and then enter the prompted path so that you can run `livebook` directly from the command line.
   - You may prefer to install [Livebook Desktop](https://livebook.dev/#install) instead of running Livebook with an `escript`.

4. Start the Livebook server and open the navigation page where you can find the course reading material and associated exercises
   - `livebook server start.livemd`

### Windows+WSL (Ubuntu)

1. Install the Ubuntu distribution application from the Windows store [here](https://apps.microsoft.com/store/detail/ubuntu-on-windows/9NBLGGH4MSV6?hl=en-ca&gl=CA). Follow the instructions in the description to ensure WSL in enabled on your system.

2. Follow the installation steps below for Linux (Ubuntu) inside the Ubuntu WSL application you just downloaded.

### Linux (Ubuntu)

1. Clone the project
   - `git clone https://github.com/DockYard-Academy/beta_curriculum.git`

2. Install Elixir
      - Add the Erlang Solutions repository
         - `wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb`
      - Update the package repository list
         - `sudo apt-get update`
      - Install Erlang
         - `sudo apt-get install esl-erlang`
      - Install Elixir
         - `sudo apt-get install elixir`

3. Install [Livebook](https://github.com/livebook-dev/livebook)
   - `mix escript.install hex livebook`

4. Start the Livebook server and open the navigation page where you can find the course reading material and associated exercises
   - `livebook server start.livemd`

## Troubleshooting

Raise an issue or contact brooklin.myers@dockyard.com if you are having trouble setting up the curriculum.

### Could not compile dependency :aws_signature

When installing Livebook `mix escript.install github livebook-dev/livebook` you may see the following error.

```
** (Mix) Could not compile dependency :aws_signature, "/home/user/.mix/rebar3 bare compile --paths /tmp/mix-local-installer-fetcher-Ao9gNA/deps/new package/_build/prod/lib/*/ebin" command failed. Errors may have been logged above. You can recompile this dependency with "mix deps.compile aws_signature", update it with "mix deps.update aws_signature" or clean it with "mix deps.clean aws_signature"
```

To resolve this issue, update `rebar3` by running the following command.

```sh
mix local.rebar
```

Then try installing Livebook again. This time it should succeed.

### Livebook: Command Not Found (ASDF)

If using [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies) you need to create the [shim](https://github.com/asdf-vm/asdf-elixir#elixir-escripts-support) for livebook.

```sh
asdf reshim
```

### Livebook: Command Not Found

After installing livebook `mix escript.install github livebook-dev/livebook` you may see the following message:

```
warning: you must append "/home/user/.mix/escripts" to your PATH if you want to invoke escripts by name
```

This means we need to append `.mix/escripts` to the PATH variable in order to find the location of the `.mix/escripts` folder when we run the livebook command.

Try running the following to confirm you can run Livebook. Stop Livebook once you have confirmed it runs successfully.

```sh
~/.mix/escripts/livebook server
```

Different operating systems use different configuration files, typically either `.bashrc` on Windows and Linux or `.zshrc` on MacOS.
If you want to run `livebook` instead of  `~/.mix/escripts/livebook`, add the following at the bottom of the appropriate configuration file.

```sh
PATH=$PATH:~/.mix/escripts
```

Then close your terminal and reload it, or run the following. Replace `.bashrc` with the appropriate configuration file.

```sh
source .bashrc
```

Now you can run Livebook using the `livebook` command.

```sh
livebook server
```

### Livebook server not starting (Windows)

This is a known Livebook issue ([196](https://github.com/livebook-dev/livebook/issues/196), [194](https://github.com/livebook-dev/livebook/issues/194), [1042](https://github.com/livebook-dev/livebook/issues/1042)) that happens when some Erlang files don't show a dialog for its firewall approval on the first Livebook execution after being installed.

- Before calling Livebook, execute `iex --sname test` on terminal.
- On appearing Windows firewall dialog, approve permission for `epmd.exe`.
- Both `erl.exe` and `epmd.exe` should appear on firewall-allowed apps.

### Unable to locate package (Linux, Windows+WSL)

On a new install of a Linux distribution the package list does not come updated and you need to run (in Ubuntu) `sudo apt update`. This is also true when adding a new package such as when we add the Erlang Solutions repository.

## Spell Checking

This project uses [codespell](https://github.com/codespell-project/codespell) for spell checking.

If contributing to the project, install codespell and run the following command to fix any spelling errors. Ensure all corrections are correct before committing altered files.

```
codespell --skip="./utils/deps/*,./.git/*,./utils/lib/assets/*" -w
```

## Changing Mix Install

Use the following Regular Expression to rapidly change the `Mix.install/2` section in every livebook.

```
Mix\.install(.|\n(?!\]))*\n\]\)
```

## Course Outcome
Students will be competent developers prepared to excel in the Elixir industry. They will have
a solid grasp of Elixir fundamentals, Elixir project development, Phoenix project development, LiveView, and OTP.
They will also have the researching and problem-solving skills necessary to expand their skill set and thrive
throughout their career. Students will be capable of delivering high-quality, well-tested features to a production complexity codebase.

## Curriculum Outline
The curriculum is still a rough outline subject to change and feedback. see [start.livemd](https://github.com/DockYard-Academy/beta_curriculum/blob/main/start.livemd) for a full breakdown.

<!-- course-outline-start -->
## Core Syntax
* Course Tools
* Basics
* Data Structures and Intro to Pattern Matching
* Control Flow and Abstraction
* Modules and Structs
* Enumeration
* Comprehensions and Non-Enumerable Data Types
* Built-in Modules
* Reduce
* Dates and Time
* Advanced Pattern Matching
* Guards
* String Manipulation
## Mix Projects
* Elixir Build Tooling
* Testing With ExUnit
* ExUnit With Mix Projects
* Documentation and Static Analysis
* Executables
## OTP and Advanced Syntax
* Protocols
* Recursion
* Benchmarking and Performance
* Streams
* Performance Optimization
* Processes
* GenServers
* Asynchronous Messages
* Supervisor Basics and Fault Tolerance
* Testing GenServers
* Mix Projects & Processes
* Concurrency With Tasks
* State Management With Agents and ETS
* Persistence Using the File System
* Rubix Cube Project
## Web Servers and Phoenix
* HTML and CSS
* APIs & Parsing JSON
* Phoenix
* Data Validation
* Relational Database Management Systems and Ecto
* Phoenix and Ecto
* Phoenix Authentication
* Testing Phoenix
* Phoenix and Ecto One-to-Many Relationships
* Phoenix and Ecto Many-to-Many Relationships
* Phoenix and Ecto One-to-One Relationships
* Tailwind
## LiveView
* LiveView
* Testing LiveView
* Phoenix Forms
* PubSub and Channels
* GraphQL and Absinthe
## Capstone Project Preparation
* Capstone Project
* UX/UI Design + Accessibility
## Quality Assurance
* Observability
* Factories & Mocks
* CI/CD, Code Coverage, GitHub Actions & Hooks
## Group Project
* Project Management
* Group Project
## External Libraries
* Emailing & Swoosh
* Oban
* Advanced Livebook
## Elixir Applications in Production
* Umbrella Projects
* Genserver Bottlenecks
* Worker Pools
* Deployment
## Final Project
* Demo Day
<!-- course-outline-end -->

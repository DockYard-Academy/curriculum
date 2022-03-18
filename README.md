# Beta Academy Curriculum
## QuickStart
1. install [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies) or a compatable Elixir and Erlang version.
2. Install livebook main `mix escript.install github livebook-dev/livebook`.
3. Ensure the `.env` file is loaded in your environment with `source .env` from the `beta_curriculum` folder.
4. Run the project with `livebook server start.livemd`.

If you cannot see mermaid.js graphs, ensure your livebook version is correct.

## Class time

Class time will be broken into
1. **Assessment & Review**
2. **Introductory Lecture**
3. **Exercises**
4. **Reading & Support**

### Grading
Students will not receive a number or letter grade for this course. Due to the nature of the assignments,
this course will be completion-based and rely on the intrinsic motivation of learning and self-improvement rather than carrot and stick motivation.

For more on this see [Mark Rober's Talk](https://www.youtube.com/watch?v=9vJRopau0g0&ab_channel=TEDxTalks).

## Student Goals
Students will be competent developers prepared to excel in the Elixir industry. They will have
a solid grasp of Elixir fundamentals, Elixir project development, Phoenix project development, LiveView, and OTP.
They will also have the researching and problem-solving skills necessary to expand their skill set and thrive
throughout their career. Students will be capable of delivering high-quality, well-tested features to a production complexity codebase.

## Writing Contribution Guide

- Code keywords such as `defimpl`, `defprotocol`, and `end` should use backticks (``).
- Important or new concepts should be in **bold** the first time you introduce them.
- Use title case without a period in headers.
- Code should be in an executable elixir cell unless it is pseudocode or it reduces the clarity of the lesson.
- Text should be run through [grammarly](https://app.grammarly.com/) to ensure correctness. The free features should be sufficient.
- Lessons should have a **Setup** section for any necessary dependencies.
- Each new major concept should be in its own section. Each section should strive to provide at least one student interaction portion, typically using the **Your Turn** heading.

## Curriculum Outline
The curriculum is still a rough outline subject to change and feedback.

## Week 1 (Livebook Setup)
1. Course Overview, Command Line, Git, Livebook, PATH
2. Basics (Simple Types, Operators, Variables, Comments)
3. Complex Types (atom, tuples, list, keyword list, map, mapset)
4. Modules, Functions, Structs, Control Flow
5. 

## Week 2
1. Problem Solving & Enumeration (ranges, map, filter, all, any, count, find, random)
2. Comprehensions, Enum.reduce
3. Built-In Modules (Map, Tuple, List, Date & Time)
4.  Guards, Pattern Matching
5. String Manipulation (Regex, Charlist vs Strings)

## Week 3
1. Polymorphism, Protocols & Behaviors
2. Performance (Immutability, Streams, Lists Vs Tuples Vs Maps Vs Mapsets, Big O, Benchee, :Timer) & Recursion
3. 
4. File, .iex Scripts, Persistence, Data Validation (Ecto Changesets) (+Binary)
5. Processes (Processes, Generic Server, Genserver, Agents, ETS)

## Week 4 (Dev Setup)
1. Mix Tooling (Credo, Dialyzer, Config, Deps, Documentation, ExUnit)
2. Supervisor Basics and Fault Tolerance (+Task)
3. BEAM, Nodes and Distributed Elixir
4. Ecto & Database Basics
5. 

## Week 5
1. APIs & Parsing JSON
2. Networking Basics & Plug 
3. Macros and `use`
4. Deploying Mix Project
5.  

## Week 6 (Phoenix Setup)
1. Phoenix Framework & Generators (+ Testing Patterns)
2. HTML & CSS (+ Flex, Grid)
3. Ecto & RDBMS & SQL & Seeding Data
4. Tailwind
5. UX/UI Design + Accessibility (ColorZilla, Axe, Figma)

## Week 7
1. Phoenix Authentication & Permissions
2. LiveView (+ Testing Patterns)
3. JavaScript & JS Interoptability & AlpineJS
4. PubSub & Channels
5. GraphQL & Absinthe (+ Testing Patterns)

## Week 8
1. TDD Techniques (Red Green Refactor), Code Clarity, Mix Testing Tools (--slowest, --stale, tags, Elixir Test extension)
2. Metrics, Telemetry, Live Dashboard
3. Factories & Mocks (ExMachina, Mox)
4. Property Based Testing (Stream Data) + E2E Testing (Wallaby)
5. Code Coverage, Github Actions & Hooks

## Week 9 (Group Project)
1. Software & Product Management (Agile, StandUps)
2. Architecture Design & Patterns (Diagrams, UML, CQRS/ES, Contexts, MVC)
3. Advanced Livebook (Graphs, Tables, Connecting Projects)
4. Collaborative Github Patterns (PRs, Forking, Cloning, Issues)
5. 

## Week 10
1. Emailing & Swoosh
2. Stripe
3. Oban
4. RabbitMQ
5. Mnesia

## Week 11
1. Umbrella Projects
2. Genserver Bottlenecks, Supervision Trees, Worker Pools, Tasks
3. Nodes, Clustering
4. Deployment w/ Kubernetes & Distillery
5. 


## Week 12 (Final Project)
1. 
2. 
3. 
4. 
5. 

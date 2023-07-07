# Mastery

**An Elixir project that allows you to generate and take quizzes. Based on the demo project presented in the book [Designing Elixir Systems with OTP](https://pragprog.com/titles/jgotp/designing-elixir-systems-with-otp/) by James Edward Gray, II and Bruce A. Tate.**

## Requirements
- Make sure Elixir is installed on your system.
- Requires postgres to be installed and running.
- An internet connection to fetch the dependencies.

## Installation
- Checkout this project from this repository.
- Change to the project directory.
- Make sure postgres is installed and running.
- Change to `mastery_persistence` directory using `cd mastery_persistence`
- Run the command `mix ecto.create; mix ecto.migrate`
- Change back to `mastery` directory.
- Start `iex` shell to play using `iex -S mix`.

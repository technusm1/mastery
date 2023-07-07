defmodule Mastery do
  alias Mastery.Boundary.Proctor
  alias Mastery.Boundary.QuizSession
  alias Mastery.Core.Quiz
  alias Mastery.Boundary.TemplateValidator
  alias Mastery.Boundary.QuizValidator
  alias Mastery.Boundary.QuizManager

  @persistence_fn Application.compile_env(:mastery, :persistence_fn)
  def build_quiz(fields) do
    with :ok <- QuizValidator.errors(fields),
         :ok <- QuizManager.build_quiz(fields) do
      :ok
    else
      error -> error
    end
  end

  def add_template(title, fields) do
    with :ok <- TemplateValidator.errors(fields),
         :ok <- QuizManager.add_template(title, fields) do
      :ok
    else
      error -> error
    end
  end

  def take_quiz(title, email) do
    with %Quiz{}=quiz <- QuizManager.lookup_quiz_by_title(title),
         {:ok, _} <- QuizSession.take_quiz(quiz, email) do
      {title, email}
    else
      error -> error
    end
  end

  def select_question(session) do
    GenServer.call(QuizSession.via(session), :select_question)
  end

  def answer_question(session, answer, persistence_fn \\ @persistence_fn) do
    QuizSession.answer_question(session, answer, persistence_fn)
  end

  def schedule_quiz(quiz, templates, start_at, end_at, notify_pid \\ nil) do
    with :ok <- QuizValidator.errors(quiz),
         true <- Enum.all?(templates, &(:ok == TemplateValidator.errors(&1))),
         :ok <- Proctor.schedule_quiz(quiz, templates, start_at, end_at, notify_pid),
    do: :ok, else: (error -> error)
  end
end

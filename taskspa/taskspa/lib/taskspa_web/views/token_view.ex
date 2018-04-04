defmodule TaskspaWeb.TokenView do
  use TaskspaWeb, :view

  def render("token.json", %{worker: worker, token: token}) do
    %{
      worker_id: worker.id,
      token: token,
    }
  end
end

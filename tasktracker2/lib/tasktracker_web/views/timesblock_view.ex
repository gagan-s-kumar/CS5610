defmodule TasktrackerWeb.TimesblockView do
  use TasktrackerWeb, :view
  alias TasktrackerWeb.TimesblockView

  def render("index.json", %{timesblocks: timesblocks}) do
    %{data: render_many(timesblocks, TimesblockView, "timesblock.json")}
  end

  def render("show.json", %{timesblock: timesblock}) do
    %{data: render_one(timesblock, TimesblockView, "timesblock.json")}
  end

  def render("timesblock.json", %{timesblock: timesblock}) do
    %{id: timesblock.id,
      start_time: timesblock.start_time,
      end_time: timesblock.end_time}
  end
end

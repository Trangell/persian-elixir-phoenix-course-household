defmodule Household.Extera.CalendarConverter do
  def jalali_string_to_miladi_english_number(persian_datetime) do
    {:ok, jalaali_datetime} = NaiveDateTime.from_iso8601("#{persian_datetime}")
    jalaali_datetime = %{jalaali_datetime | calendar: Jalaali.Calendar}
    {:ok, gregorian_datetime} = NaiveDateTime.convert(jalaali_datetime, Calendar.ISO)
    {:ok, dt, _number} = DateTime.from_iso8601("#{NaiveDateTime.to_string(gregorian_datetime)}Z")
    dt
  end

  def miladi_to_jalaali(datetime) do
    {:ok, jalaali_datetime} = DateTime.convert(datetime, Jalaali.Calendar)
    jalaali_datetime
    |> DateTime.to_string()
    |> String.replace("Z", "")
  end

  def jalali_create(time_need, "number") do
    {:ok, jalaali_date} = Date.convert(time_need, Jalaali.Calendar)
    %{day_number: jalaali_date.day, month_name: jalaali_date.month, year_number: jalaali_date.year}
  end

  def jalali_create(time_need) do
    {:ok, jalaali_date} = Date.convert(time_need, Jalaali.Calendar)
    %{day_number: jalaali_date.day, month_name: get_month(jalaali_date.month), year_number: jalaali_date.year}
  end

  def get_month(id) do
    case id do
      1 -> "فروردین"
      2 -> "اردیبهشت"
      3 -> "خرداد"
      4 -> "تیر"
      5 -> "مرداد"
      6 -> "شهریور"
      7 -> "مهر"
      8 -> "آبان"
      9 -> "آذر"
      10 -> "دی"
      11 -> "بهمن"
      12 -> "اسفند"
    end
  end

end
# f.data.delivery_time

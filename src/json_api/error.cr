module JsonAPI
  def error(status, title, detail = title)
    {
      errors: [
        {
          title: title,
          detail: detail,
          status: status,
          code: status
        }
      ]
    }.to_json
  end
end

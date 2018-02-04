module JsonAPI
  def error(title, status)
    {
      errors: [
        {
          title: title,
          status: status
        }
      ]
    }.to_json
  end
end

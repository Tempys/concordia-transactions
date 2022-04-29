[[inputs.exec]]
  ## Commands array
commands = [
  "/etc/telegraf/get_node_state.sh"
 ]

  ## Timeout for each command to complete.
 timeout = "60s"

  ## measurement name suffix (for separating different commands)  name_suffix = "_node_status"

  ## Data format to consume.
  ## Each data format has its own unique set of configuration options, read
  ## more about them here:
  ## https://github.com/influxdata/telegraf/blob/master/docs/DATA_FORMATS_INPUT.md
  data_format = "value"
  data_type = "integer" # required


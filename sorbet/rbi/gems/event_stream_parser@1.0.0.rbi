# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `event_stream_parser` gem.
# Please instead update this file by running `bin/tapioca gem event_stream_parser`.

# source://event_stream_parser//lib/event_stream_parser/version.rb#3
module EventStreamParser; end

# Implements a spec-compliant event stream parser, following:
#
# https://html.spec.whatwg.org/multipage/server-sent-events.html
# Section: 9.2.6 Interpreting an event stream
#
# Code comments are copied from the spec.
#
# source://event_stream_parser//lib/event_stream_parser.rb#14
class EventStreamParser::Parser
  # @return [Parser] a new instance of Parser
  #
  # source://event_stream_parser//lib/event_stream_parser.rb#15
  def initialize; end

  # source://event_stream_parser//lib/event_stream_parser.rb#30
  def feed(chunk, &proc); end

  # source://event_stream_parser//lib/event_stream_parser.rb#55
  def stream; end

  private

  # @yield [type, data, id, @reconnection_time]
  #
  # source://event_stream_parser//lib/event_stream_parser.rb#165
  def dispatch_event; end

  # source://event_stream_parser//lib/event_stream_parser.rb#220
  def ignore; end

  # source://event_stream_parser//lib/event_stream_parser.rb#111
  def process_field(field, value); end

  # source://event_stream_parser//lib/event_stream_parser.rb#61
  def process_line(line, &proc); end
end

# source://event_stream_parser//lib/event_stream_parser/version.rb#4
EventStreamParser::VERSION = T.let(T.unsafe(nil), String)

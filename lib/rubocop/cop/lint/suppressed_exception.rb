# frozen_string_literal: true

module RuboCop
  module Cop
    module Lint
      # This cop checks for *rescue* blocks with no body.
      #
      # @example
      #
      #   # bad
      #   def some_method
      #     do_something
      #   rescue
      #   end
      #
      #   # bad
      #   begin
      #     do_something
      #   rescue
      #   end
      #
      #   # good
      #   def some_method
      #     do_something
      #   rescue
      #     handle_exception
      #   end
      #
      #   # good
      #   begin
      #     do_something
      #   rescue
      #     handle_exception
      #   end
      #
      # @example AllowComments: true (default)
      #
      #   # good
      #   def some_method
      #     do_something
      #   rescue
      #     # do nothing
      #   end
      #
      #   # good
      #   begin
      #     do_something
      #   rescue
      #     # do nothing
      #   end
      #
      # @example AllowComments: false
      #
      #   # bad
      #   def some_method
      #     do_something
      #   rescue
      #     # do nothing
      #   end
      #
      #   # bad
      #   begin
      #     do_something
      #   rescue
      #     # do nothing
      #   end
      class SuppressedException < Cop
        MSG = 'Do not suppress exceptions.'

        def on_resbody(node)
          return if node.body
          return if cop_config['AllowComments'] && comment_lines?(node)

          add_offense(node)
        end

        private

        def comment_lines?(node)
          processed_source[line_range(node)].any? { |line| comment_line?(line) }
        end
      end
    end
  end
end

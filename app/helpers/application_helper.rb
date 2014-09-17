module ApplicationHelper
  class Errors
    class NeedsSignInException < Exception
      attr_reader :message
      def initialize
        @message = :profile_needs_sign_in
      end
    end

    def self.pretty_denial_message(action, subject)
      puts "action = #{action}, subject = #{subject.class}"

      if action==:new and subject.class==FormEntry
        return :volunteers_create_formentry
      end

      # In all other cases, return a generic message
      return :access_denied_message
    end
  end
end


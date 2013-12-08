class ProblemsetsController < ApplicationController

	def ps1

		begin
	      @thisIsCausingZeroErro = 0/0
	      rescue ZeroDivisionError => ex
	        logger.error (Time.now.to_s + 'User triggered zero division error')
	        @error = "User Just Triggered error of division by 0"
	    end

	    agent = Mechanize.new
	    #agent.set_proxy '192.41.170.23', 3128
	    agent.get('http://www.yahoo.com')
	    @listFromYahoo = agent.page.search('ol[@class="lh-192 trendingnow_trend-list fw-b"]/li/a') 
	end

	def ps2
	end

	def ps3
	end

	def ps4
	end

	def ps5
	end

	def ps6
	end
end

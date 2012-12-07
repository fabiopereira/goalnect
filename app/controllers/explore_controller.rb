class ExploreController < ApplicationController
  include GoalExplorer
  
  def goals_from_donations goal_donations
    goal_donations.map {|d| d.goal }
  end
  
  def goals
    @goals_latest = Goal.latest.explore_limit

    recent_donations = GoalDonation.approved.recent.includes(:goal).limit(3)
    @goals_with_recent_donation = goals_from_donations(recent_donations)

    @goals_random_scope = Goal.random_scope.explore_limit
  end
end
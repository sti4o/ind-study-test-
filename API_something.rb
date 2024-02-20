require 'httparty'
require 'json'

# Function to fetch commits from a GitHub repository
def fetch_commits(user, repo, access_token)
  url = "https://api.github.com/repos/#{user}/#{repo}/commits"
  headers = {
    "User-Agent" => "Ruby/#{RUBY_VERSION}",
    "Authorization" => "token #{access_token}"
  }
  response = HTTParty.get(url, headers: headers)

  if response.code == 200
    commits = JSON.parse(response.body)
    commits.each_with_index do |commit, index|
      puts "Commit \##{index+1}:"
      puts "Author: #{commit['commit']['author']['name']}"
      puts "Date: #{commit['commit']['author']['date']}"
      puts "Message: #{commit['commit']['message']}\n\n"
    end
  else
    puts "Failed to fetch commits: #{response.code} - #{response.message}"
  end
end

# Function to fetch detailed repository information (e.g., for grading)
def fetch_repo_details(user, repo, access_token)
  url = "https://api.github.com/repos/#{user}/#{repo}"
  headers = {
    "User-Agent" => "Ruby/#{RUBY_VERSION}",
    "Authorization" => "token #{access_token}"
  }
  response = HTTParty.get(url, headers: headers)

  if response.code == 200
    repo_details = JSON.parse(response.body)
    # Output some basic details; customize this based on grading needs
    puts "Repository: #{repo_details['name']}"
    puts "Owner: #{repo_details['owner']['login']}"
    puts "Stars: #{repo_details['stargazers_count']}"
    puts "Forks: #{repo_details['forks_count']}"
    puts "Open Issues: #{repo_details['open_issues_count']}"
    # Add more details as needed for grading
  else
    puts "Failed to fetch repository details: #{response.code} - #{response.message}"
  end
end

# Variables: GitHub username, repository name, and your personal access token
user = 'sti4o' # Replace with the GitHub username
repo = 'sa4-act3' # Replace with the repository name
access_token = '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' # Replace with your GitHub personal access token

# Fetch and display commits and repository details
fetch_commits(user, repo, access_token)
fetch_repo_details(user, repo, access_token)

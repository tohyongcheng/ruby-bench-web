class ReposController < ApplicationController
  def show
    @repo = Repo.find_by(name: params[:repo_name])
    @commits = @repo.commits

    @commits_sha1s = []
    @commits_data = {}

    @commits.includes(:benchmark_runs).reverse.each do |commit|
      if commit_benchmark_run = commit.benchmark_runs.first
        @commits_sha1s << commit.sha1[0..4]

        commit_benchmark_run.result.each do |key, value|
          @commits_data[key] ||= [key]
          @commits_data[key] << value
        end
      end
    end
  end
end

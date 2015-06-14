import sublime, sublime_plugin
import os
import re

# view.run_command('toy_test_runner')

class ToyTestRunnerCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        print "ToyTestRunnerCommand"
        print args

        file_path = self.view.file_name()
        project_dir = file_path

        while project_dir != "/":
            head, tail = os.path.split(project_dir)
            project_dir = head
            search_file = os.path.join(project_dir, ".test_runner_socket")
            print "searching " + search_file
            if os.path.exists(search_file):
                break

        spec = re.compile('.+_spec\.rb$')
        feature = re.compile('.+\.feature$')

        relative_file_path = file_path.replace(project_dir + "/", "")
        command = False

        print "relative_file_path"
        print relative_file_path
        row, col = self.view.rowcol(self.view.sel()[0].begin())
        line_number = row + 1

        if spec.match(relative_file_path):
            command = "bundle exec rspec --color " + relative_file_path + ":" + str(line_number)

        if feature.match(relative_file_path):
            command = "bundle exec cucumber --color " + relative_file_path + ":" + str(line_number)

        if command:
            print "Found project dir " + project_dir
            os.chdir(project_dir)
            print "Running $ testrunner-client " + command
            os.system("testrunner-client " + command)
        else:
            print "no command found for " + relative_file_path

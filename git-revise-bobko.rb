# https://github.com/Homebrew/homebrew-core/blob/master/Formula/g/git-revise.rb
class GitReviseBobko < Formula
  include Language::Python::Virtualenv

  desc "Rebase alternative for easy & efficient in-memory rebases and fixups"
  homepage "https://github.com/nikitabobko/git-revise"
  license "MIT"
  head "https://github.com/nikitabobko/git-revise.git", branch: "main"

  depends_on "python@3.12"

  conflicts_with "git-revise"

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/".gitconfig").write <<~EOS
      [user]
        name = J. Random Tester
        email = test@example.com
    EOS
    system "git", "init"
    (testpath/"test").write "foo"
    system "git", "add", "test"
    system "git", "commit", "--message", "a bad message"
    system "git", "revise", "--message", "a good message", "HEAD"
    assert_match "a good message", shell_output("git log --format=%B -n 1 HEAD")
  end
end

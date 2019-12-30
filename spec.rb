require_relative './db'
require 'rspec'
describe Database do
  let(:db_url) {'postgres://localhost/framework_dev'}
  let(:queries) do
    {
      create_submission: %{
        insert into submissions(name)
        values($1)
      },
      find_submission: %{
        select * from submissions
        where name = $1
      }

    }
  end

  let(:db){ Database.connect(db_url,queries)}

  it "does not have sql injection vulnerabilities" do
    name = "' : drop table submissions; --'"
    expect {db.create_submission(name)}
    .to change {db.find_submission(name).length}
    .by(1)
  end

  it "retrieves record that it has inserted" do
    db.create_submission('Alice')
    alice = db.find_submission('Alice').fetch(0)
    expect(alice.name).to eq 'Alice'
  end
end

require_relative '../lib/user_repo'

def reset_users_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do

  before(:each) do 
    reset_users_table
  end


  it "returns all users" do
    repo = UserRepository.new
    users = repo.all

    expect(users.length).to eq(3)
    expect(users.first.id).to eq(1)
    expect(users.last.name).to eq('The Rock')
  end

  it "finds a single user" do
    repo = UserRepository.new
    user = repo.find(2)
    expect(user.id).to eq(2)
    expect(user.name).to eq('Stone Cold Steve Austin')
    expect(user.username).to eq('stonecoldstunner')
  end

  it "finds a single user" do
    repo = UserRepository.new
    user = repo.find(3)
    expect(user.id).to eq(3)
    expect(user.name).to eq('The Rock')
    expect(user.username).to eq('peopleseyebrow')
  end

  it "creates a new user" do
    repo = UserRepository.new

    new_user = User.new
    new_user.name = 'Mankind'
    new_user.username = 'mrsocko'
    new_user.email = 'mandibleclaw@weemail.com'
    new_user.password = 'Password'

    repo.create(new_user)

    users = repo.all

    expect(users.length).to eq(4)
    expect(users.last.id).to eq(4)
    expect(users.last.name).to eq('Mankind')
    expect(users.last.username).to eq('mrsocko')
    expect(users.last.email).to eq('mandibleclaw@weemail.com')
    expect(users.last.password).to eq('Password')
  end

end
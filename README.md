# AccessForge

Welcome to Access Forge! Access Forge is an authorization solution for Ruby On Rails. It is lightweight, flexible, and extendable.

Simply include a helper in you controller, create a policy with the same base name as your controller, and write some authorization logic for your actions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'access_forge'
```

And then execute:

    $ bundle install

## Usage

### Step 1: Include AccessForge::ControllerHelpers in your controllers

```
class ApplicationController < ActionController::API
  include AccessForge::ControllerHelpers
end
```

### Step 2: Add a hook to authorize your users before each action

```
class ApplicationController < ActionController::API
  include AccessForge::ControllerHelpers

  before_action :authorize_user!
end
```

### Step 3: Implement your policy classes

Access Forge will use your policy classes to perform authorization checks. The `authorize_user!` hook will find your policy class based on the name of your controller, e.g. if you have a controller called `EmployeesController`, it will use the `EmployeePolicy` for authorization.

Your policy classes should inherit from `AccessForge::Policy`, either directly or via your Application Policy.

```
class ApplicationPolicy < AccessForge::Policy
end

class EmployeePolicy < ApplicationPolicy
end
```

Optionally, if you would like to use a different policy class for your controller, you could override the `#policy_class` method on your controller and return your desired class from there.

```
class EmployeesController < ApplicationController
  def policy_class
    DifferentPolicy
  end
end
```

### Step 4: Implement your policy methods

If Access Forge finds your policy class, it will attempt to run the corresponding method for your controller action. For example, the hook for the `show` action will call the `show?` method on the policy.

The policy method should return either `true` or `false`, based on your authorization logic. A `false` result will prevent the action from being performed and return a 401 response to the user. A `true` result will allow the action to be performed as usual.

```
class EmployeePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    false
  end
end
```

Each of your controller actions will need a corresponding policy method. However, if you have identical authorization logic for your `index` and `show` actions, you can simply use `can_read?` instead. You can also use `can_write?` if you have identical authorization logic for your `create`, `update`, and `destroy` actions.

```
class EmployeePolicy < ApplicationPolicy
  def can_read?
    true
  end

  def can_write?
    false
  end
end

### Step 5: Implement your policy rules

If you have reusable authorization logic, it may be better to place it in a Policy Rule class.

`AccessForge::Policy` contains a method called `authorized?`, which accepts 2 parameters - an array of Policy Rule classes and an optional hash that will be passed to each rule along with the current user and controller. If any of the rules returns a `true` result, the user is authorized and the action will be performed as usual.

Access Forge includes 2 default Policy Rules - `OpenPolicyRule` and `ClosedPolicyRule`. `OpenPolicyRule` always grants access to the action, while `ClosedPolicyRule` always blocks access to the action. The `can_read?` and `can_write?` policy methods both use `ClosedPolicyRule` by default.

```
module AccessForge
  class OpenPolicyRule
    def self.authorized?(_user, _controller, _options)
      true
    end
  end

  class ClosedPolicyRule
    def self.authorized?(_user, _controller, _options)
      false
    end
  end
end
```

You can use your own policy rules as follows:

```
class PermissionPolicyRule
  def self.authorized?(user, _controller, options)
    permission_name = "Can #{options[:verb]} #{options[:feature]}"
    user.permissions.exists?({ permissions: { name: permission_name } })
  end
end

class EmployeePolicy < ApplicationPolicy
  def index?
    authorized?(
      [ PermissionPolicyRule ],
      { feature: 'Employees', verb: :read }
    )
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

To release a new version of this gem, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CodeTectonics/access_forge. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/CodeTectonics/access_forge/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AccessForge project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CodeTectonics/access_forge/blob/main/CODE_OF_CONDUCT.md).

ExUnit.start()
# avoids issues with module attributes not being loaded.
System.cmd("mix", ["compile", "--force"],  env: [{"MIX_ENV", "test"}])

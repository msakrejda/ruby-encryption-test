Sequel.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table(:fernet_encrypteds) do
      uuid :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      text :unencrypted
      text :encrypted
    end

    create_table(:asym_encrypteds) do
      uuid :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      timestamptz  :created_at, default: Sequel.function(:now), null: false
      text :unencrypted
      text :encrypted
    end

    create_table(:steps) do
      uuid :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      uuid :run_id, null: false
      text :mode, null: false
      text :step, null: false
      float8 :duration, null: false
    end
  end
end

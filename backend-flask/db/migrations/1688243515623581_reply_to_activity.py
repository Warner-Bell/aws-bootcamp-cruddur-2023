from lib.db import db

class ReplyToActivityMigration:
  def migrate_sql():
    data = """
    """
    return data
  def rollback_sql():
    data = """
    """
    return data

  def migrate():
    db.query_commit(ReplyToActivityMigration.migrate_sql(),{
    })

  def rollback():
    db.query_commit(ReplyToActivityMigration.rollback_sql(),{
    })

migration = ReplyToActivityMigration
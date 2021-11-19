//
// Copyright (c) 2021 Emarsys. All rights reserved.
//

import Foundation

enum SchemaContract {
    enum Request {
        static let tableName = "request"

        enum ColumnName {
            static let requestId = "request_id"
            static let method = "method"
            static let url = "url"
            static let headers = "headers"
            static let payload = "payload"
            static let timestamp = "timestamp"
            static let expiry = "expiry"
        }

        enum Query {
            static let insert = "INSERT INTO \(Request.tableName) (\(Request.ColumnName.requestId), \(Request.ColumnName.method), \(Request.ColumnName.url), \(Request.ColumnName.headers), \(Request.ColumnName.payload), \(Request.ColumnName.timestamp), \(Request.ColumnName.expiry)) VALUES (?, ?, ?, ?, ?, ?, ?);"
            static let selectFirst = "SELECT * FROM \(Request.tableName) ORDER BY ROWID ASC LIMIT 1;"
            static let selectAll = "SELECT * FROM \(Request.tableName) ORDER BY ROWID ASC;"
            static let deleteItem = "DELETE FROM \(Request.tableName) WHERE \(Request.ColumnName.requestId) = ?;"

            static func deleteMultipleItem(ids: String) -> String {
                "DELETE FROM \(Request.tableName) WHERE \(Request.ColumnName.requestId) IN \(ids);"
            }

            static let purge = "DELETE FROM \(Request.tableName);"
            static let count = "SELECT COUNT(*) FROM \(Request.tableName);"
        }
    }

    enum Shard {
        static let tableName = "shard"

        enum ColumnName {
            static let type = "type"
            static let shardId = "shard_id"
            static let timestamp = "timestamp"
            static let ttl = "ttl"
            static let data = "data"
        }

        enum Query {
            static let insert = "INSERT INTO \(Shard.tableName) (\(Shard.ColumnName.shardId), \(Shard.ColumnName.type), \(Shard.ColumnName.data), \(Shard.ColumnName.timestamp), \(Shard.ColumnName.ttl)) VALUES (?, ?, ?, ?, ?);"
            static let selectAll = "SELECT * FROM \(Shard.tableName) ORDER BY ROWID ASC;"
            static let selectLast = "SELECT * FROM \(Shard.tableName) ORDER BY ROWID DESC LIMIT 1;"

            static func selectByType(type: String) -> String {
                "SELECT * FROM \(Shard.tableName) WHERE \(Shard.ColumnName.type) LIKE '\(type)' ORDER BY ROWID ASC;"
            }

            static func deleteMultipleItem(ids: String) -> String {
                "DELETE FROM \(Shard.tableName) WHERE \(Shard.ColumnName.shardId) IN (\(ids));"
            }

            static let count = "SELECT COUNT(*) FROM \(Shard.tableName);"
        }
    }

    enum Migration {
        static let upgradeFrom0To1 = [
            "CREATE TABLE IF NOT EXISTS request (request_id TEXT,method TEXT,url TEXT,headers BLOB,payload BLOB,timestamp REAL, expiry DOUBLE DEFAULT \(Float.greatestFiniteMagnitude);",
            "CREATE TABLE IF NOT EXISTS shard (shard_id TEXT,type TEXT,data BLOB,timestamp REAL,ttl REAL);",
            "CREATE INDEX shard_id_index ON shard (shard_id);",
            "CREATE INDEX shard_type_index ON shard (type);",
            IAM.Query.createTable,
            ButtonClick.Query.createTable]

        static func setSchemaUpgradeVersion(version: Int) -> String {
            "PRAGMA user_version=\(version);"
        }

        static let migration = [Migration.upgradeFrom0To1]
    }

    enum IAM {
        static let tableName = "displayed_iam"

        enum ColumnName {
            static let campaignId = "campaign_id"
            static let timestamp = "timestamp"
        }

        enum Query {
            static let createTable = "CREATE TABLE IF NOT EXISTS \(IAM.tableName) (\(IAM.ColumnName.campaignId) TEXT, \(IAM.ColumnName.timestamp) DOUBLE);"
            static let insert = "INSERT INTO \(IAM.tableName) (\(IAM.ColumnName.campaignId), \(IAM.ColumnName.timestamp)) VALUES (?, ?);"
        }
    }

    enum ButtonClick {
        static let tableName = "button_click"

        enum ColumnName {
            static let campaignId = "campaign_id"
            static let timestamp = "timestamp"
            static let buttonId = "button_id"
        }

        enum Query {
            static let createTable = "CREATE TABLE IF NOT EXISTS \(ButtonClick.tableName) (\(ButtonClick.ColumnName.campaignId) TEXT, \(ButtonClick.ColumnName.buttonId) TEXT, \(ButtonClick.ColumnName.timestamp) DOUBLE);"
            static let insert = "INSERT INTO \(ButtonClick.tableName) (\(ButtonClick.ColumnName.campaignId), \(ButtonClick.ColumnName.buttonId), \(ButtonClick.ColumnName.timestamp)) VALUES (?, ?, ?);"

            static func select(filter: String) -> String {
                "SELECT * FROM \(ButtonClick.tableName) \(filter);"
            }

            static func deleteItem(from filter: String) -> String {
                "DELETE FROM \(ButtonClick.tableName) \(filter);"
            }

            static let purge = "DELETE FROM \(ButtonClick.tableName);"
            static let count = "SELECT COUNT(*) FROM \(ButtonClick.tableName);"
        }
    }
}
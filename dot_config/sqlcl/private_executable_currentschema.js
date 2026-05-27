// SQLCLs Command Registry
var CommandRegistry = Java.type("oracle.dbtools.raptor.newscriptrunner.CommandRegistry");

// CommandListener for creating any new command
var CommandListener = Java.type("oracle.dbtools.raptor.newscriptrunner.CommandListener");

// SQLCommand for command types
var SQLCommand = Java.type("oracle.dbtools.raptor.newscriptrunner.SQLCommand");

// DBUtil for obtaining instance for current runtime connection!
var DBUtil = Java.type("oracle.dbtools.db.DBUtil");

var currentSchemaPropertyName = "jml.currentschema"

// Custom function for getting the current_schema
var getDatabaseCurrentSchema = function(conn) {
    var currentSchema;

    if (conn != null) {
        currentSchema = util.executeReturnList(
            "select sys_context('userenv', 'current_schema') current_schema from sys.dual",
            null
        )[0].CURRENT_SCHEMA;
    }

    if (currentSchema === undefined || currentSchema === "") {
        currentSchema = "NOLOG";
    }

    return currentSchema;
}

var setCurrentSchemaProperty = function(conn, ctx) {
    ctx.putProperty(currentSchemaPropertyName, getDatabaseCurrentSchema(conn));
}

var getCurrentSchemaProperty = function(ctx) {
    return ctx.getProperty(currentSchemaPropertyName)
}

// Setup parts used for CommandListener extensions
var cmd = {
    handle: function(conn,ctx,cmd) { return false; },
    // fired before any command
    begin: function(conn,ctx,cmd) {},
    // fired after CONNECT command
    endConnect: function(conn,ctx,cmd) {
        setCurrentSchemaProperty(conn, ctx);
    },
    // fired after DISCONNECT command
    endDisconnect: function(conn,ctx,cmd) {
        setCurrentSchemaProperty(null, ctx);
    },
    // fired after ALTER command
    endAlter: function(conn,ctx,cmd) {
        setCurrentSchemaProperty(conn, ctx);
    }
}

// Setup connect command extension
var ConnectCommand = Java.extend(CommandListener, {
    handleEvent:    cmd.handle,
    beginEvent:     cmd.begin,
    endEvent:       cmd.endConnect
});
CommandRegistry.addListener(ConnectCommand.class, SQLCommand.StmtSubType.G_S_CONNECT);

// Setup disconnect command extension
var DisconnectCommand = Java.extend(CommandListener, {
    handleEvent:    cmd.handle,
    beginEvent:     cmd.begin,
    endEvent:       cmd.endDisconnect
});
CommandRegistry.addListener(DisconnectCommand.class, SQLCommand.StmtSubType.G_S_DISCONNECT);

// Setup alter command extension
var AlterCommand = Java.extend(CommandListener, {
    handleEvent:    cmd.handle,
    beginEvent:     cmd.begin,
    endEvent:       cmd.endAlter
});
CommandRegistry.addListener(AlterCommand.class, SQLCommand.StmtSubType.G_S_ALTER);

// Create and register new StatusBarComponent
var StatusBarComponent = Java.type("oracle.dbtools.raptor.console.StatusBarComponent");

var component = new StatusBarComponent({
    getName: function() {
        return "currentschema";
    },
    getDescription: function() {
        return "Show the current schema for the database session";
    },
    update: function(context) {
        context.append(getCurrentSchemaProperty(ctx));
    }
});

try {
    ctx.getConsoleService().registerStatusBarComponent(component);
}
catch (e) {
    if (e.getMessage() !== "Component with name '" + component.getName() + "' is already registered.") {
        throw e;
    }
}

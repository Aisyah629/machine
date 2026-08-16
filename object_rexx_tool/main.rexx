/**
 * Object REXX - System Configuration Manager
 * Purpose: Automated environment setup and configuration management.
 * Language: Object REXX
 */

/* Initialize core objects */
call init_config_manager

/* Main execution flow */
parse arg config_file
if config_file = '' then do
    say 'Usage: rexx main.rexx <config_file>'
    exit 1
end

if verify_config_file(config_file) = 0 then do
    say 'Error: Configuration file not found or invalid.'
    exit 2
end

parsed_config = parse_config(config_file)
validated_config = validate_config(parsed_config)
if validated_config = .false then do
    say 'Error: Configuration validation failed.'
    exit 3
end

result = setup_environment(validated_config)
if result \= 'SUCCESS' then do
    say 'Error: Environment setup failed. Reason:' result
    exit 4
end

say 'Environment setup completed successfully.'
exit 0

/* Method: Initialize the configuration manager */
init_config_manager:
    config_manager = .config_manager~new
    return

/* Method: Verify existence and accessibility of config file */
verify_config_file:
    expose config_manager
    parse arg file
    if file~is_file then
        return 1
    else
        return 0

/* Method: Parse configuration file */
parse_config:
    expose config_manager
    parse arg file
    config_lines = .array~new
    do i = 1 to file~lines
        line = file~linein
        line = line~strip
        if line \= '' & line\~left(1) \= '#' then
            do
                parse value line with key '=' value
                config_lines~append(key || '=' || value)
            end
    end
    return config_lines

/* Method: Validate parsed configuration */
validate_config:
    expose config_manager
    parse arg config_data
    if config_data~size \= 0 then
        return .true
    else
        return .false

/* Method: Setup environment based on validated config */
setup_environment:
    expose config_manager
    parse arg config_data
    do i = 1 to config_data~size
        entry = config_data~item(i)
        parse value entry with key '=' value
        address system 'export ' key '=' value
    end
    return 'SUCCESS'

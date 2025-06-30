#include <a_samp>

#define MAX_MESSAGE_LENGTH 144

ProcessTagMessage(playerid, const message[])
{
    new processedMessage[256];
    new currentPos = 0;
    new messageLength = strlen(message);

    for(new i = 0; i < messageLength; i++)
    {
        if(message[i] == '@')
        {
            if(i + 1 < messageLength && '0' <= message[i + 1] <= '9')
            {
                new targetId = 0;
                new j = i + 1;

                while(j < messageLength && '0' <= message[j] <= '9')
                {
                    targetId = (targetId * 10) + (message[j] - '0');
                    j++;
                }

                if(IsPlayerConnected(targetId))
                {
                    new targetName[MAX_PLAYER_NAME];
                    GetPlayerName(targetId, targetName, sizeof(targetName));

                   
                    strcat(processedMessage[currentPos], targetName, sizeof(processedMessage) - currentPos);
                    currentPos += strlen(targetName);

                    i = j - 1;
                    continue;
                }
            }
        }

     
        processedMessage[currentPos] = message[i];
        currentPos++;
    }

    processedMessage[currentPos] = EOS;

    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));

    new finalMessage[256];
    format(finalMessage, sizeof(finalMessage), "%s says: %s", playerName, processedMessage);
    SendClientMessageToAll(-1, finalMessage);
    return 1;
}

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Tag System By https://github.com/mizuuuu1337 Loaded");
    print("--------------------------------------\n");
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}

public OnPlayerText(playerid, text[])
{
    if(strfind(text, "@", true) != -1)
    {
        ProcessTagMessage(playerid, text);
        return 0; 
    }
    return 1;
}

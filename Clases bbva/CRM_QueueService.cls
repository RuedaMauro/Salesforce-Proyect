/**
  * -------------------------------------------------------------------------------------------------
  * @Name   CRM_QueueService
  * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
  * @Date   Created: 2022-01-10
  * -------------------------------------------------------------------------------------------------
  * @Description Queue service class
  * -------------------------------------------------------------------------------------------------
  * @Changes
  *
  **/
public with sharing class CRM_QueueService {

    public class QueueElement{
        @AuraEnabled
        public Group queue {get; set;}

        @AuraEnabled
        public Boolean itBelongs {get; set;}

        public QueueElement(Group queue, Boolean itBelongs){
            this.queue = queue;
            this.itBelongs = itBelongs;
        }
    }

    public class Response{
        @AuraEnabled
        public String status {get; set;}

        @AuraEnabled
        public String message {get; set;}
    }

    /**
      * @Description This method retrieves social queues
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @return QueueElement
      **/
    @AuraEnabled(cacheable=true)
    public static List<QueueElement> getSocialQueues(){
        List<Group> socialQueues = new List<Group>();
        List<QueueElement> queueElements = new List<QueueElement>();
        try {
            socialQueues = [SELECT Name, DeveloperName, Type, (SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Type = 'Queue' AND DeveloperName LIKE 'CRM_SCC_Cas_Soc%' WITH SECURITY_ENFORCED LIMIT :Limits.getLimitQueryRows()];

            for(Group queue : socialQueues){
                QueueElement qe = new QueueElement(queue, false);
                if(belongsToQueue(queue)){
                    qe.itBelongs = true;
                }

                queueElements.add(qe);
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());//NOSONAR
        }

        String response = JSON.serialize(queueElements);

        return queueElements;
    }

    /**
      * @Description This method change queue assignment for current user based on the id of owned and not owned queues
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @param ownedQueues: Ids of owned queues
      * @param notOwnedQueues: Ids of not owned queues
      * @return Response
      **/
    @AuraEnabled
    public static Response changeQueueAssignment(List<Id> ownedQueues, List<Id> notOwnedQueues){
        List<Group> queuesToAdd = new List<Group>();
        List<Group> queuesToRemove = new List<Group>();
        Response res = new Response();
        try {
            queuesToAdd = [SELECT Name, DeveloperName, Type, (SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Id IN :ownedQueues WITH SECURITY_ENFORCED LIMIT :Limits.getLimitQueryRows()];
            queuesToRemove = [SELECT Name, DeveloperName, Type, (SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Id IN :notOwnedQueues WITH SECURITY_ENFORCED LIMIT :Limits.getLimitQueryRows()];

            if(!queuesToAdd.isEmpty()){
                insertGroupMember(queuesToAdd);
            }

            if(!queuesToRemove.isEmpty()){
                deleteGroupMember(queuesToRemove);
            }
            res.status = 'success';
            res.message = 'Se actualizaron correctamente los datos';
        } catch (Exception e) {
            res.status = 'error';
            res.message = e.getMessage();
            throw new AuraHandledException(e.getMessage());//NOSONAR
        }

        return res;
    }

    /**
      * @Description This method inserts a new GroupMember for a list of queues
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @return void
      **/
    private static void insertGroupMember(List<Group> queuesToAdd){
        List<GroupMember> membersToAdd = new List<GroupMember>();

        for(Group singleQueue : queuesToAdd){
            if(!belongsToQueue(singleQueue)){
                membersToAdd.add(createGroupMember(singleQueue));
            }
        }

        insert membersToAdd;
    }

    /**
      * @Description This method deletes a GroupMember for a list of queues
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @return void
      **/
    private static void deleteGroupMember(List<Group> queuesToRemove){
        List<GroupMember> membersToDelete = new List<GroupMember>();

        for(Group singleQueue : queuesToRemove){
            if(belongsToQueue(singleQueue)){
                membersToDelete.add(getGroupMember(singleQueue));
            }
        }

        delete membersToDelete;
    }

    /**
      * @Description This method retrieves social queues
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @return GroupMember
      **/
    private static GroupMember getGroupMember(Group queue){
        Id userId = UserInfo.getUserId();
        GroupMember member = new GroupMember();

        for(GroupMember gm : queue.GroupMembers){
            if(gm.UserOrGroupId == userId){
                member = gm;
            }
        }

        return member;
    }

    /**
      * @Description This method creates a GroupMember instance
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @return GroupMember
      **/
    private static GroupMember createGroupMember(Group queue){
        return new GroupMember(GroupId = queue.Id, UserOrGroupId = UserInfo.getUserId());
    }

    /**
      * @Description This method checks if the current user belongs to a given queue
      * -------------------------------------------------------------------------------------------------
      * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
      * @param queue: Queue to be verified if the current user belongs to
      * @return Boolean
      **/
    private static Boolean belongsToQueue(Group queue){
        Boolean itBelongs = false;
        Id userId = UserInfo.getUserId();

        for(GroupMember gm : queue.GroupMembers){
            if(gm.UserOrGroupId == userId){
                itBelongs = true;
            }
        }

        return itBelongs;
    }
}
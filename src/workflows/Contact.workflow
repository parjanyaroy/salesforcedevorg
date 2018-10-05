<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>send_email_to_contact_when_trigger_box_is_checked</fullName>
        <ccEmails>parjroy@deloitte.com</ccEmails>
        <description>send email to contact when trigger box is checked</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/testEmailTemplate</template>
    </alerts>
    <rules>
        <fullName>Send Email When Box Is Checked</fullName>
        <actions>
            <name>send_email_to_contact_when_trigger_box_is_checked</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Email_Trigger__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send Email When Box Is Checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>send_email_to_contact_when_trigger_box_is_checked</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contact.CreatedDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>

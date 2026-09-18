## Cancer Incidence in Five Continents Volume XIII

## Call for Data Data Specification Protocol

## Submission Notes

## 1 September 2026

## Introduction

Cancer Incidence in Five Continents (CI5), now in its 13th iteration, continues to provide unique insights into

the occurrence of cancer around the world. It also provides a vital link of communication and collaboration between population-based cancer registries around the world, the International Association of Cancer Registries (IACR) and the International Agency for Research on Cancer (IARC). The new Volume XIII (CI5-XIIII) will include incident cancers for the period 2018-2022 and this document provides detailed instructions on the content and process of the submission. Consistent with previous practice, submitted datasets will be processed and analyzed by relevant IARC staff and stored on secure servers to ensure confidentiality. These datasets will then be carefully evaluated by the CI5-XIIII Editorial Board to ensure the incidence data published in CI5 are sufficiently comparable, complete and accurate (see also Chapters 5 and 6 of Volume XII). Please remember that, as an IACR publication, datasets will only be considered from IACR member registries and those who are not yet members should consult the IACR website for application details. Volume XIII will

be disseminated as an online and abridged pdf.

## The final deadline for data submission will be 30 November 2026.

## Summary

This page summarizes the most important aspects of the CI5-XIII call for data. Please click on the different links to access more detailed information about each element.

## General Information

The target incidence period for CI5-XIII is 2018-2022. Data from three consecutive years within this time period are the minimum that will be considered for publication. Cancer registries are, however, encouraged to submit all available data from years prior to 2018, and if complete, after 2022. The published version of Volume XIII will only contain 2018-2022 data but the pre-2018 information will be used to update previously supplied datasets and assess certain quality issues (see also Chapters 5 and 6 of Volume XII). Many registries experienced operational disruptions during the pandemic affecting case ascertainment during the years 2020 and 2021. During the review process, datasets conveying evidence of a shortfall in cases during one or both of these years will be marked with an asterisk. The post-2022 data will be included with other available years (if considered complete) in the corresponding web-based data visualisation tools (see the letter accompanying this call), ensuring each registry's data is timely on the IARC and IACR online databases.

## Checklist of Items Required

- Incidence data as a listing of individual cancer cases
- Population data from official censuses or intercensal/post-censal estimates
- Mortality data (where available), preferably from official vital statistics offices
- Population lifetable data (where available), preferably from official vital statistics offices
- A coding file if the coding rules differ from those requested in this document
- Completion of the online questionnaire to provide details of the registry and the catchment population

## Data Quality and Coding

Incidence data should be verified and corrected prior to submission using, for example, IARCcrgTools. Note that for some combinations of site/morphology/behaviour, accurate recoding requires a decision to provide corrections. Users can use the IARC flag variable to mark validated records.

## File Format and Data Submission

Please submit separate files for incidence, population and mortality data. The datasets should be fieldseparated using any of the following: comma, semi-column, tab or pipe character (|). A fully automated and secured mechanism has been set up for submissions to CI5XIII at IARC's dedicated registry portal. Where possible, all registries are requested to use this facility for the submission of files and for completion of the questionnaire. Files should not be zipped together but may be zipped individually (if they are large). They may be protected by a password which is then to be provided on the system. Please contact the editorial office (ci5@iarc.who.int) if you have any questions.

## Incidence Dataset

## General Information

All primary tumours diagnosed at all ages between 2018 and 2022 should be submitted, including (if collected) basal cell and squamous cell carcinoma of the skin and non-malignant tumours of the central nervous system and of the urinary bladder. Data should be submitted as a case listing (one case per line).

## Required Variables

(mandatory variables in bold and preceded by a *) (Read More).

| Variable            | Format                                                                                                            | Unknown/Miss ing   | Definition/Notes                                                                                                                                                |
|---------------------|-------------------------------------------------------------------------------------------------------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Ethnic group        |                                                                                                                   | 99                 | If available, Read more                                                                                                                                         |
| *Patient ID         |                                                                                                                   | Not allowed        | Unique ID of the patient in the registry Read more                                                                                                              |
| Tumour sequence #   | 00 = single tumour 01 = 1st of several tumours 02 = 2nd of several tumours…                                       | 99                 | If only one tumour is identified for a patient, this variable should contain '00'. If several tumours are identified, numbering should start at '01'. Read more |
| *Date of Birth      | YYYYMMDD                                                                                                          | 99999999           | Read more                                                                                                                                                       |
| *Sex                | 1 = Male 2 = Female                                                                                               | 9                  |                                                                                                                                                                 |
| *Date of Incidence  | YYYYMMDD                                                                                                          | Not allowed        | Read more                                                                                                                                                       |
| *Age in Years       |                                                                                                                   | 999                | Last completed year of age: <1 = 0, >99 = 100. Read more                                                                                                        |
| *ICDO-3 Topography  | ICDO-3 Definition (with letter C)                                                                                 | Not allowed        | E.g. C531                                                                                                                                                       |
| *ICDO-3 Morphology  | ICDO-3 Definition                                                                                                 | Not allowed        | E.g. 8170                                                                                                                                                       |
| *ICDO-3 Behaviour   | ICDO-3 Definition                                                                                                 | Not allowed        | E.g. 3                                                                                                                                                          |
| ICD-O-3 version     | 0 1 2                                                                                                             |                    |                                                                                                                                                                 |
| *Basis of Diagnosis | 0 Death certificate only 1 Clinical 2 Clinical investigation 4 Specific tumor markers 5 Cytology 6 Histology of a | 9                  | Read more                                                                                                                                                       |

|                      | metastasis 7 Histology of a primary tumor 9 Unknown   |          |                                 |
|----------------------|-------------------------------------------------------|----------|---------------------------------|
| Vital Status         | 1 = Alive 2 = Dead 3 = Lost to follow- up             |        9 | Read more                       |
| Date of Last Contact | YYYYMMDD                                              | 99999999 | Read more                       |
| IARC Flag            | 1 = OK 2 = Checked 0 = Failed                         |        9 | Read more                       |
| TNM Stage            | 1= stage I 2= stage II 3= stage III 4= stage IV       |        9 | Read more                       |
| TNM edition          | 7= UICC 7th edition 8= UICC 8th edition E= E TNM      |       99 | UICC TNM edition used Read more |

## Definition of Variables

## Ethnic group

If the registry data permits analysis by ethnic group, the relevant category should be appropriately coded in the Cancer Cases File AND the Population File using the same sub-populations. If mortality data are provided, they should also (where possible) include this variable. When information on ethnic group is provided, a description of the codes used must also be submitted.

## Patient identification number

This is the unique number (or character string) permitting the registry identification of the record in their files. The patient identification number should be unique to ensure that if the same individual is reported again to the registry, s/he will be recognized as being the same person. In conjunction with the variable 'Tumour sequence number' it allows the editors to recognize multiple tumours as registered by the registry. The submitted information should NOT allow the identification of a person in real life. Names of

patients should never be included in the Cancer Cases File.

## Tumour sequence number

This number, allocated by the registry, permits distinction as well as order of occurrence of different tumours registered for the same patient. If only one tumour is identified for a patient, this variable should contain '00'. If more than one tumour is identified, numbering should start at '01'.

## Dates

The calendar year in all dates should always be coded to four digits (with century: for example, 1903, 2003, etc.). All dates should be submitted in the following format: YYYYMMDD

## Date of birth

If date of birth cannot be provided in full, the next possible/available detail should be included, such as YYYYMM99 if only the year and month of birth are available.

## Date of incidence

Month and year are required as a minimum. Registries commonly define incidence date from one of a number of available dates and use hierarchal rules for determination of the date of incidence. Some of these rules are available for download.

## Age (in years)

The last completed year of age is to be used in the calculation. Cases less than one year of age should be coded as age 0. Do not use the same code for unknown age and over 99 years. Code for unknown age should be 999. If a different code is used, it must be described in the Coding File.

## Basis of diagnosis

This variable indicates the degree of certainty with which a diagnosis of cancer has been established, on the basis of the following coding scheme:

| Code            | Description                  | Criteria                                                                                                                                                                                           |
|-----------------|------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 0               | Death certificate only       | Information provided is from a death certificate. See definition in Volume XII, Chapter 5                                                                                                          |
| Non-microscopic | Non-microscopic              | Non-microscopic                                                                                                                                                                                    |
| 1               | Clinical                     | Diagnosis made before death, but without any of the following (codes 2-7).                                                                                                                         |
| 2               | Clinical investigation       | All diagnostic techniques, including X-ray, endoscopy, imaging, ultrasound, exploratory surgery (such as laparotomy), and autopsy, without a tissue diagnosis.                                     |
| 4               | Specific tumor markers       | Including biochemical and/or immunologic markers that are specific for a tumor site.                                                                                                               |
| Microscopic     | Microscopic                  | Microscopic                                                                                                                                                                                        |
| 5               | Cytology                     | Examination of cells from a primary or secondary site, including fluids aspirated by endoscopy or needle; also includes the microscopic examination of peripheral blood and bone marrow aspirates. |
| 6               | Histology of a metastasis    | Histologic examination of tissue from a metastasis, including autopsy specimens.                                                                                                                   |
| 7               | Histology of a primary tumor | Histologic examination of tissue from primary tumor, however obtained, including all cutting techniques and bone marrow biopsies; also includes autopsy specimens of primary tumor.                |
| 9               | Unknown                      |                                                                                                                                                                                                    |

## Vital status

The patient vital status known at the latest date or at study closing date must be recorded. The coding is:

|   Code | Description            |
|--------|------------------------|
|      1 | Alive                  |
|      2 | Dead                   |
|      3 | Lost to follow-up      |
|      9 | Vital status not known |

'Lost to follow - up' could be coded when both active and passive methods were adopted and the patient could not be followed up till the closing date or at 5 years of potential follow up. 'Unknown' vital status would be coded when the patient could not be traced by both active and passive methods and the last known date is not later than the date of diagnosis.

## Date of last contact

If the patient is dead, then the date of last contact is the date of death. If the vital status of the patient is alive, then the date corresponding to the most recent date of known vital status must be used. This is not the date when an attempt for contact was made, if the current vital status could not be confirmed.

## IARC flag

Please use this variable to indicate which records have already been checked, for example using IARCcrgTools - this will greatly reduce processing time and avoid unnecessary requests for verifications to your registry.

## TNM Stage

TNM Stage is based on TNM components. It can be based on combined clinical and pathological data when only partial information is available, with a preference given to pathological information (apart from M component where clinical information might be required).

## TNM Edition

The TNM Classification of Malignant Tumours, 8th Edition (link), published in 2016, provides internationally agreed-upon standards to describe and categorize cancer stages and progression. It contains important updated organ-specific classifications that oncologists and other professionals who manage patients with cancer need can use to accurately classify tumours for staging, prognosis and treatment.

A description of changes between the 7th and 8th editions is available here.

## File format

In general, the files should be formatted one record per line (case listing) using a delimited field format. Mandatory variables must be completed for all records, while optional variables must be completed for all records, if provided. In files containing data for several populations, each population should be distinguished by a specific code and

the code should be provided in a separate file and submitted with the data.

## Population Dataset

## General Information

The possible sources of population data are from official censuses, or from intercensal/postcensal estimates provided by civil registration and vital statistics (CRVS), or equivalent. Census data (with reference date) should be supplied for the period during, before and after the years covered in your dataset of cancer records. Any official estimates of the population made during the period should also be sent, preferably for each individual calendar year. If possible, population figures should give the mid-year (as of 1st July) estimates (or mid-period estimates) for each sub-category.

References to all sources of population data are requested and should be provided in the questionnaire. This information will be printed in the publication (or online) under the population pyramid of the registry page. Any unpublished estimates should be documented in the questionnaire. If population data are not available for this period, any available data should be submitted, clearly describing their source, reference area and period.

The population dataset, and the codes used in this file, should correspond to the cancer cases file with respect to ethnic groups, registration area, time period, sex and age range.

## Population Data Variables

(mandatory variables in bold and preceded by a *).

| Variable             | Format            | Unknown/Missing   | Definition/Notes                                                                             |
|----------------------|-------------------|-------------------|----------------------------------------------------------------------------------------------|
| *Year                | 4 digits, YYYY    | Not allowed       |                                                                                              |
| *Sex                 | Same as Incidence | Not allowed       |                                                                                              |
| *Age / Age group     |                   | Not allowed       | Age groups: 1 = 0-4 years of age, 2 = 5-9 years of age, 3 = 10- 14 years of age, …, 18 = 85+ |
| *Number of residents |                   | Not allowed       |                                                                                              |
| Ethnic group         | Same as Incidence | 99                | If provided in case listing                                                                  |

## File Format

Each line of the Population File should include the number of residents for a combination of calendar year, sex and age. Age should be provided as a single year if possible or as standard 18 age-groups otherwise, using the same age groups codes as for the incidence data (e.g. 1=0-4 years of age, 2=59 years of age, … 17=80 -84 years of age, 18=85+). The coding of the age groups should be appropriately adjusted and documented if there are less than 18 age groups available. Please provide the numbers of persons of unknown age if applicable.

Examples of acceptable file formats:

|   Year |   Sex | Age / 5-year age group   | Number of residents   |
|--------|-------|--------------------------|-----------------------|
|   1991 |     1 | 0                        |                       |
|   1991 |     1 | 1                        |                       |
|   1991 |     1 | ...                      |                       |
|   2008 |     2 | 18                       |                       |

8

## Mortality Dataset

## General Information

The mortality data should consist of all certified deaths from cancer among residents of the registration area during the same period as that covered by the incidence data. Wherever possible, the mortality data should be the official cancer mortality data, as obtained from the Vital Statistics Department or equivalent and based on certificates/death records. Mortality data (where available) will be used in Volume XII, as in previous volumes, to calculate the ratios of mortality to incidence by site.

National cancer registries are not required to submit national mortality statistics, as these can be retrieved directly from the WHO database. The mortality data for sub-national regions covered by a cancer registry should include all past residents whose underlying cause of death was cancer.

The mortality dataset as well as the codes used in this file should correspond to the cancer cases file with respect to ethnic groups (if available), registration area, time period, sex, age range and cause of death.

## Mortality Data Variables

(mandatory variables in bold and preceded by a *).

| Variable          | Format            | Unknown/Missing   | Definition/Notes                                                                             |
|-------------------|-------------------|-------------------|----------------------------------------------------------------------------------------------|
| *Year             | 4 digits          | Not allowed       |                                                                                              |
| *Sex              | Same as Incidence | Not allowed       |                                                                                              |
| *Age / Age group  |                   | Not allowed       | Age groups: 1 = 0-4 years of age, 2 = 5-9 years of age, 3 = 10- 14 years of age, …, 18 = 85+ |
| *Cause of death   | ICD-10            | Not allowed       | E.g. C61                                                                                     |
| *Number of deaths |                   | Not allowed       |                                                                                              |
| Ethnic group      | Same as Incidence | 99                | If provided in case listing                                                                  |

## File Format

Each line of the Mortality File should include number of deaths for a combination of calendar year, sex, age and cause of death (3 characters of the applicable ICD code, preferably ICD-10).

Age should be provided as a single year if possible or as standard 18 age-groups otherwise, using the same age groups codes as for the incidence data (e.g. 1=0-4 years of age, 2=59 years of age, … 17=80 -84 years of age, 18=85+). The coding of the age groups should be appropriately adjusted and documented if there are less than 18 age groups available. The total number of deaths can be provided if no breakdown information by agegroup is available.

## Population life table dataset

The life table data should consist of all-cause mortality probabilities among residents of the registration area during the same period as that covered by the incidence data (2018-2022). The underlying mortality data should be obtained from the Vital Statistics Department or equivalent and based on certificates/death records.

Please provide references to all sources for the life table data submitted.

| Variable               | Format                    | Unknown/Missing   | Definition/Notes                                           |
|------------------------|---------------------------|-------------------|------------------------------------------------------------|
| *Year                  | YYYY                      | Not allowed       | Needs to be provided for all incidence and follow-up years |
| *Sex                   | 1=Male 2=Female           | Not allowed       |                                                            |
| *Age                   | Numeric                   | Not allowed       |                                                            |
| *Mortality probability | Numeric, 6 decimal places | Not allowed       |                                                            |

## File Format

Each line of the population life table dataset should include mortality probabilities for a combination of calendar year, sex and age. Age should be provided as a single year. Please provide the numbers of persons of unknown age, if applicable.

If available, additional lifetables should be provided by socioeconomic group, ethnic group using the same coding as in the incidence dataset.

## Coding File

This file is to be used to supply details of any non-standard coding conventions used or to provide information on any unique codes specific to your registry.

Examples of the possible contents:

- Changes in the registration coverage
- Local definition of incidence date
- Coding of basis of diagnosis that differs from the codes proposed in this document
- Coding of ethnic group
- Description of the methodology used to derive population figures in the absence of published population data
- Any other information useful for processing the submitted dataset
- Any other information useful to evaluate the results

## Questionnaire

The questionnaire is an essential part of the submission. The information provided in the questionnaire will help the Editorial Board evaluate the submitted datasets. Selected information from the questionnaire will be tabulated in the printed volume (or online) and will help those using published data to interpret results correctly. The questionnaire is available on the registries portal and should be completed online. Unless otherwise specified, all answers should refer to the target registration period, 2018 - 2022.

To access the questionnaire, please connect to the registry's portal here using the username and the password of your registry and select the 'questionnaires' section.

If you have any issues with access, please contact the editorial office at ci5@iarc.who.int.

## Downloads / Links

CI5-XIII data submissions Registries Portal Access : Access Publications Cancer Incidence in Five Continents, Volume XII: Download Software IARCcrgtools: Download Websites International Association of Cancer Registries (IACR): Access International Agency for Research on Cancer (IARC): Access Global Cancer Observatory: Access Cancer Incidence in Five Continents (Web Application): Access Registries' portal: Access

## Classifications and Coding

International Classification of Diseases for Oncology (ICD-O-3): Access European Network of Cancer Registries (ENCR) Recommendations for Coding of Incidence Date: Download SEER Program Coding and Staging Manual: Download Multiple Primary rules: IARC/IACR, SEER Rules for coding of 'Basis of Diagnosis' (IARC): Download

## Other

Questionnaire in printable format: Download
# bigspark Data Engineering Challenge: Frontend

## Summary

For this challenge there are 2 sections: 
- The basic task section should be completed by all applicants: this is to create a single-page web application with some basic data visualisations.
- The stretch goals can be optionally completed to demonstrate capability in specific areas, or using specific tooling you may already be experienced with. The key here is to demonstrate what you can do, and in which areas of the data landscape you are particularly interested. As such, if you have an idea for how to extend the basic task in a way which is not listed below, please go ahead: it would be great to walk through and discuss your ideas. 

Task submission will be in the form of a 10-15 minute demo over video call, followed by around 10 minutes of discussion around your approach and any challenges you faced in completing this challenge.

We appreciate that your time is valuable, and due to the open-ended nature of the listed tasks we know that it may not be 
possible to implement all of your ideas. If this is the case then please still submit whatever you have, 
and be prepared to discuss what you would have liked to implement if you'd had more time.


## Task Description

### Basic Task
1. Access the TPC-DS data available on our AWS S3 bucket. Details for this dataset are provided [here](#base-dataset-tpcds_data_5g), and access instructions are provided [here](#data-access).
   - You may either download this data locally and access it from your local disk, or connect your spark session directly to S3.
   - Data documentation is here: http://tpc.org/tpc_documents_current_versions/pdf/tpc-ds_v3.2.0.pdf
2. Create a single-page web application with some data visualisations using the data provided. This can be written in any language or using any framework which you are comfortable with. For Javascript, you may find it helpful to use the [D3|https://d3js.org] library for this.

### (Optional: Attempt 1 or More) Stretch Goals
1. [**Frontend Development**] Create some more advanced visualisations, including interactive fields for filtering, changing graph settings etc
2. [**DevOps**] Dockerize your approach such that all required services and data can be brought up with a single docker command
3. [**Cloud Engineering**] Implement the basic task on a cloud platform of your choice & be prepared to discuss your deployment choices with your interviewer.
4. [**Data Engineering Core**] Integrate the basic task into a larger data processing pipeline which makes the transformed data available to your app in  database of your choice, ready for visualisation.
5. [**Data Engineering Core**] Frame the basic task as a transaction-level streaming problem using an event streaming tool of your choice (an example script `helper-scripts/create-kafka-events.sh`is provided to load events onto Apache Kafka). Details for this dataset are given [below](#streaming-dataset-tpcds_data_5g_streaming).
6. [**Data Engineering Core**] Frame the basic task as a periodic batch problem, with new batches of fact and dimension data arriving monthly. End users of reports should be able to view at least 1 data view or visualization in Zeppelin as of an arbitrary past date. Details for this dataset are given [below](#quarterly-batch-dataset).
7. [**Software Engineering**] Put together a basic design for how you might implement the end-to-end process from data sourcing to productionized reporting for hundreds of users in a large enterprise environment. Please include a diagram describing your approach and be prepared to discuss your design choices at a high level.
8. [**Data Science**] Perform more advanced data visualizations or interactive data analytics to extract insights from the data. Be prepared to demonstrate a critical analysis of the data, and discuss any shortcomings of your approach. 
9. [**Machine Learning**] Extract some insights from the data using supervised or unsupervised learning. You may find larger dataset `tpcds_data_10g` easier for this due to dataset size.

# Dataset Description

## Base Dataset: tpcds_data_5g
The TPC-DS dataset is a benchmark dataset used to benchmark the performance of various big data tooling on specific queries.
Documentation for this dataset is available here: \
http://tpc.org/tpc_documents_current_versions/pdf/tpc-ds_v3.2.0.pdf

We have created a cut-down version of the dataset to reduce the total data volume. This reduced dataset is labelled `tpcds_data_5g` on our S3 bucket.
With all tables included, this data forms a snowflake schema. However, if you choose to integrate the streaming and batch tasks then you may choose to focus on the store_sales fact table, which we have used to generate pseudo batch and streaming data for those two extended tasks.

Files available:
```bash
.
├── ddl
│   └── create_tables.sql
├── call_center.dat
├── catalog_page.dat
├── catalog_returns.dat
├── catalog_sales.dat
├── customer.dat
├── customer_address.dat
├── customer_demographics.dat
├── date_dim.dat
├── dbgen_version.dat
├── household_demographics.dat
├── hs_err_pid93510.log
├── income_band.dat
├── inventory.dat
├── item.dat
├── output
├── promotion.dat
├── reason.dat
├── ship_mode.dat
├── store.dat
├── store_returns.dat
├── store_sales.dat
├── time_dim.dat
├── warehouse.dat
├── web_page.dat
├── web_returns.dat
├── web_sales.dat
└── web_site.dat
```

## Streaming Dataset: tpcds_data_5g_streaming
To simulate a streaming use case, we have created a cut-down version of the base dataset focused on the single fact table store_sales and associated dimension tables, which together form their own star schema.
Within the dataset folder `tpcds_data_5g_streaming`, you will find 2 subfolders containing:
1. `initial_load_upto_2002`: an initial batch of the store_sales fact table along with the associated dimension tables
2. `streaming_data_after_2002`: a streaming folder containing new records for the store_sales table: each row of each file should be considered a new event:
```bash
tpcds_data_5g_streaming
├── initial_load_upto_2002
│   ├── customer.dat
│   ├── customer_address.dat
│   ├── customer_demographics.dat
│   ├── date_dim.dat
│   ├── household_demographics.dat
│   ├── item.dat
│   ├── promotion.dat
│   ├── store.dat
│   ├── store_sales.dat
│   └── time_dim.dat
└── streaming_data_after_2002
    ├── store_sales_2003-01-01.dat
    └── store_sales_2003-01-02.dat
```

## Quarterly Batch Dataset: 
The dataset `tpcds_data_5g_batch` has been constructed to simulate a quarterly batch of both fact and dimension data for the `store_sales` schema.
Each batch directory contains the new `store_sales` transactions for that time period (inserts only), along with any inserts and updates to the
associated dimensions tables within that time period.

```bash
├── batch_1998-04-01
│   ├── customer
│   │   ├── _SUCCESS
│   │   └── part-00000-589162dd-e263-440a-8ded-537f2908a11b-c000.csv
│   ├── customer_address
│   │   ├── _SUCCESS
│   │   └── part-00000-1a3c92a8-2532-4761-8dfd-c27040d2b29a-c000.csv
│   ├── date_dim
│   │   ├── _SUCCESS
│   │   └── part-00000-c56b7fe2-8b14-4172-8403-feeab0521105-c000.csv
│   ├── household_demographics
│   │   ├── _SUCCESS
│   │   └── part-00000-ef48775b-de62-4325-94e6-a749f03db0f1-c000.csv
│   ├── item
│   │   ├── _SUCCESS
│   │   └── part-00000-e9ff2eeb-2806-4426-8db8-d95a0c836bd8-c000.csv
│   ├── promotion
│   │   ├── _SUCCESS
│   │   └── part-00000-b97444e0-d4b7-45cc-bfda-8c642c08fa55-c000.csv
│   ├── store
│   │   ├── _SUCCESS
│   │   └── part-00000-8b82cce7-e8a5-47bd-9fb6-90d822a69456-c000.csv
│   ├── store_sales
│   │   ├── _SUCCESS
│   │   └── part-00000-86d9d885-0315-4211-927d-8db564f90f07-c000.csv
│   └── time_dim
│       ├── _SUCCESS
│       └── part-00000-deef998c-b5f2-46a5-91bd-f955913f8f80-c000.csv
...
└── ddl
    └── create_tables.sql

```



# Data Access
You can use the credentials provided in your challenge invite email to access the interview test data from your scripts or command line.

The data can be accessed via AWS CLI, spark session settings, or via direct download link to your local workstation.

A bash script is included in this repository under helper-scripts/ to show how to use AWS CLI to download the data.

## Using AWS S3 UI To Access the Data

1. Go to:
[AWS Bucket Location](https://s3.console.aws.amazon.com/s3/buckets/bigspark.challenge.data?region=eu-west-1&tab=objects)
2. If prompted, select option `Sign in as IAM User`.
3. Sign in with above details
4. Click through to download data from UI

## Using AWS CLI to Access the Data
If you install and use the AWS CLI, you can configure the above access and secret keys using this method:
[Configure AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)

Once done, you can view the available datasets on the S3 bucket using:
```bash
aws s3 ls s3://bigspark.challenge.data
```

and download your chosen dataset using:
```bash
# make a directory to store the data
mkdir tpcds_data_5g
# download the dataset
aws s3 cp s3://bigspark.challenge.data/tpcds_data_5g ./tpcds_data_5g --recursive 
```

A bash script is included in this repo to run this with the appropriate credentials.

# Installation Hints For Windows
Windows users will in general find these applications to be harder to set up, as these applications are broadly built with Linux in mind.
Windows users may find that installation via Docker is simpler than a straight local install for these applications.

For local install on Windows machines, many users have found the following set-up advice helpful:
* Spark version 3.2.0 often gives java errors on startup on Windows machines. You may have better luck with Spark version 3.1.2 or below.
* Similarly, Zeppelin version 0.9.0 may be easier to install for Windows users than 0.10.

